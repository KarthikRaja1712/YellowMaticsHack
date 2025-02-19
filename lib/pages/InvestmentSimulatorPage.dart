import 'package:flutter/material.dart';
import 'dart:math';

class InvestmentSimulator extends StatefulWidget {
  @override
  _InvestmentSimulatorState createState() => _InvestmentSimulatorState();
}

class _InvestmentSimulatorState extends State<InvestmentSimulator> {
  double investedAmount = 0;
  int investmentYears = 5;
  String selectedInvestment = "Stocks";
  double expectedReturns = 0;
  double customReturnRate = 10.0; // Default return percentage

  final Map<String, double> riskReturns = {
    "Stocks": 12.0,
    "Gold": 8.0,
    "Mutual Funds": 10.0
  };

  List<double> yearlyGrowth = [];

  void calculateInvestment() {
    double rate = customReturnRate / 100;
    double amount = investedAmount;
    yearlyGrowth.clear();

    for (int i = 1; i <= investmentYears; i++) {
      amount *= (1 + rate);
      yearlyGrowth.add(amount);
    }

    setState(() {
      expectedReturns = yearlyGrowth.last - investedAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Investment Simulator"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Investment Type:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedInvestment,
              isExpanded: true,
              items: riskReturns.keys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedInvestment = value!;
                  customReturnRate = riskReturns[value]!;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Investment Amount"),
              onChanged: (value) {
                setState(() {
                  investedAmount = double.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 10),
            Text("Set Expected Return Rate (%):",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Slider(
              value: customReturnRate,
              min: 1,
              max: 20,
              divisions: 19,
              label: "${customReturnRate.toStringAsFixed(1)}%",
              onChanged: (value) {
                setState(() {
                  customReturnRate = value;
                });
              },
            ),
            SizedBox(height: 10),
            Text("Investment Duration (Years):",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Slider(
              value: investmentYears.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: "$investmentYears years",
              onChanged: (value) {
                setState(() {
                  investmentYears = value.toInt();
                });
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: calculateInvestment,
              child: Text("Simulate Investment"),
            ),
            SizedBox(height: 20),
            if (investedAmount > 0) ...[
              Text("Investment: ₹$investedAmount in $selectedInvestment",
                  style: TextStyle(fontSize: 16)),
              Text("Duration: $investmentYears years",
                  style: TextStyle(fontSize: 16)),
              Text("Expected Returns: ₹${expectedReturns.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
              SizedBox(height: 10),
              Text("Investment Growth Over Time:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Column(
                children: List.generate(yearlyGrowth.length, (index) {
                  return Text(
                      "Year ${index + 1}: ₹${yearlyGrowth[index].toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 14));
                }),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
