import 'package:flutter/material.dart';
import 'package:ymhackathon/pages/DragAndDropGameScreen.dart';
import 'package:ymhackathon/pages/Home.dart';
import 'package:ymhackathon/widgets/CardWidget.dart';

import 'InvestmentSimulatorPage.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> allGames = [
    {
      "title": "Financial Quiz Battle",
      "image": "assets/quiz_x_o.jpg",
      "page": DragAndDropGameScreen(
        question:
            'Drag and drop the following expenses into the correct categories: "Needs".',
        choices: [
          'Rent',
          'Groceries',
          'Gym Membership',
          'Netflix Subscription',
          'Electricity Bill',
          'Eating Out',
          'Car Payment'
        ],
        correctAnswers: [
          'Rent',
          'Groceries',
          'Electricity Bill',
          'Car Payment'
        ],
      )
    },
    {
      "title": "Savings Challenge",
      "image": "assets/savingchallenge.png",
      "page": Home()
    },
    {
      "title": "Scenario Decision",
      "image": "assets/scenerio.png",
      "page": Home()
    },
    {
      "title": "Investment Simulator",
      "image": "assets/investment.jpg",
      "page": InvestmentSimulator()
    },
    {
      "title": "Expense Tracker",
      "image": "assets/quiz_x_o.jpg",
      "page": Home()
    },
    {
      "title": "Loan Repayment Challenge",
      "image": "assets/quiz_x_o.jpg",
      "page": Home()
    },
    {
      "title": "Inflation Impact Game",
      "image": "assets/inflatation.png",
      "page": Home()
    },
    {
      "title": "Side Hustle Simulator",
      "image": "assets/quiz_x_o.jpg",
      "page": Home()
    },
    {
      "title": "Fraud & Scam Detection Game",
      "image": "assets/quiz_x_o.jpg",
      "page": Home()
    },
    {
      "title": "Retirement Planning Game",
      "image": "assets/quiz_x_o.jpg",
      "page": Home()
    },
  ];

  List<Map<String, dynamic>> filteredGames = [];

  @override
  void initState() {
    super.initState();
    filteredGames = List.from(allGames);
  }

  void _searchGames(String query) {
    setState(() {
      filteredGames = allGames
          .where((game) =>
              game['title']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Games"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search games...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _searchGames,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: filteredGames.length,
                itemBuilder: (context, index) {
                  final game = filteredGames[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => game['page']),
                      );
                    },
                    child: CardWidget(
                      gradient: true,
                      button: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.asset(
                                game['image']!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              game['title']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
