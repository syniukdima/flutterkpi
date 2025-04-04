import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab1/task1/utils/fuel_calculator.dart';
import 'package:flutter_labs/labs/lab1/task1/widgets/fuel_input_field.dart';
import 'package:flutter_labs/labs/lab1/task1/widgets/heating_value_results.dart';
import 'package:flutter_labs/labs/lab1/task1/widgets/mass_results.dart';

class FuelCalculatorScreen extends StatefulWidget {
  const FuelCalculatorScreen({super.key});

  @override
  FuelCalculatorScreenState createState() => FuelCalculatorScreenState();
}

class FuelCalculatorScreenState extends State<FuelCalculatorScreen> {
  double hp = 1.9, cp = 21.1, sp = 2.60, np = 0.20, op = 7.10, wp = 53.0, ap = 14.1;
  Map<String, double> dryMassResult = {};
  Map<String, double> combustibleMassResult = {};
  double lowerHeatingValueResult = 0.0;
  double lowerHeatingValueResultDry = 0.0;
  double lowerHeatingValueResultCombustible = 0.0;

  void calculateResults() {
    setState(() {
      dryMassResult =
          FuelCalculator.calculateDryMass(hp, cp, sp, np, op, wp, ap);
      combustibleMassResult =
          FuelCalculator.calculateCombustibleMass(hp, cp, sp, np, op, wp, ap);
      lowerHeatingValueResult =
          FuelCalculator.calculateLowerHeatingValueWorking(hp, cp, sp, op, wp);
      lowerHeatingValueResultDry =
          FuelCalculator.calculateLowerHeatingValueDry(hp, cp, sp, op, wp);
      lowerHeatingValueResultCombustible =
          FuelCalculator.calculateLowerHeatingValueCombustible(
              hp, cp, sp, op, wp, ap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FuelInputField(
                label: "HP",
                value: hp,
                onChanged: (v) => setState(() => hp = v)),
            FuelInputField(
                label: "CP",
                value: cp,
                onChanged: (v) => setState(() => cp = v)),
            FuelInputField(
                label: "SP",
                value: sp,
                onChanged: (v) => setState(() => sp = v)),
            FuelInputField(
                label: "NP",
                value: np,
                onChanged: (v) => setState(() => np = v)),
            FuelInputField(
                label: "OP",
                value: op,
                onChanged: (v) => setState(() => op = v)),
            FuelInputField(
                label: "WP",
                value: wp,
                onChanged: (v) => setState(() => wp = v)),
            FuelInputField(
                label: "AP",
                value: ap,
                onChanged: (v) => setState(() => ap = v)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateResults,
              child: const Text("Calculate"),
            ),
            MassResults(
              dryMassResult: dryMassResult,
              combustibleMassResult: combustibleMassResult,
            ),
            HeatingValueResults(
              lowerHeatingValueResult: lowerHeatingValueResult,
              lowerHeatingValueResultDry: lowerHeatingValueResultDry,
              lowerHeatingValueResultCombustible:
                  lowerHeatingValueResultCombustible,
            )
          ],
        ),
      ),
    );
  }
}
