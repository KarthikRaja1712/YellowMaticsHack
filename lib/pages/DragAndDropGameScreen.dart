import 'package:flutter/material.dart';

class DragAndDropGameScreen extends StatefulWidget {
  final String question;
  final List<String> choices;
  final List<String> correctAnswers;

  const DragAndDropGameScreen({
    super.key,
    required this.question,
    required this.choices,
    required this.correctAnswers,
  });

  @override
  _DragAndDropGameScreenState createState() => _DragAndDropGameScreenState();
}

class _DragAndDropGameScreenState extends State<DragAndDropGameScreen>
    with TickerProviderStateMixin {
  final List<String> draggedItems = [];
  late AnimationController shakeController;

  @override
  void initState() {
    super.initState();
    shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag & Drop Challenge',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green.shade600,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.question,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildChoicesGrid(),
            const SizedBox(height: 30),
            _buildDragTargets(),
          ],
        ),
      ),
    );
  }

  /// Builds the draggable choices
  Widget _buildChoicesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.choices.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3,
      ),
      itemBuilder: (context, index) {
        return Draggable<String>(
          data: widget.choices[index],
          child: ChoiceWidget(choice: widget.choices[index]),
          feedback: Material(
            color: Colors.transparent,
            child: ChoiceWidget(choice: widget.choices[index]),
          ),
          childWhenDragging: const ChoiceWidget(choice: ''),
        );
      },
    );
  }

  /// Dynamically adjusts the drag targets to prevent overflow
  Widget _buildDragTargets() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: List.generate(
          widget.correctAnswers.length, (index) => _buildDragTarget(index)),
    );
  }

  /// Drag target container
  Widget _buildDragTarget(int index) {
    return DragTarget<String>(
      onAccept: (receivedItem) {
        if (widget.correctAnswers.contains(receivedItem) &&
            !draggedItems.contains(receivedItem) &&
            draggedItems.length < widget.correctAnswers.length) {
          setState(() {
            draggedItems.add(receivedItem);
          });
          if (draggedItems.length == widget.correctAnswers.length) {
            _showWinDialog();
          }
        } else {
          shakeController.forward(from: 0.0);
        }
      },
      builder: (context, acceptedItems, rejectedItems) {
        return ShakeWidget(
          shakeController: shakeController,
          child: Container(
            width: 120,
            height: 75,
            decoration: BoxDecoration(
              color: draggedItems.length > index
                  ? Colors.green.shade100
                  : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueAccent),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: draggedItems.length > index
                  ? Text(
                      draggedItems[index],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : const Text('Drop here',
                      style: TextStyle(color: Colors.black54)),
            ),
          ),
        );
      },
    );
  }

  /// Displays the win dialog when the user completes the challenge
  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("🎉 Great Job!"),
          content: const Text(
            "You successfully matched the correct answers!",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Play Again"),
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame();
              },
            ),
          ],
        );
      },
    );
  }

  /// Resets the game when the user wants to replay
  void _restartGame() {
    setState(() {
      draggedItems.clear();
    });
  }
}

/// Choice Widget for draggable items
class ChoiceWidget extends StatelessWidget {
  final String choice;

  const ChoiceWidget({super.key, required this.choice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.primaries[
            choice.hashCode % Colors.primaries.length], // Dynamic color
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          choice,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// Widget for shaking effect when wrong answer is placed
class ShakeWidget extends StatelessWidget {
  final AnimationController shakeController;
  final Widget child;

  const ShakeWidget(
      {super.key, required this.shakeController, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shakeController,
      builder: (context, childWidget) {
        double offsetX = shakeController.value * 10.0;
        return Transform.translate(
          offset: Offset(offsetX, 0),
          child: childWidget,
        );
      },
      child: child,
    );
  }
}
