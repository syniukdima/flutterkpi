import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab1/task1/widgets/fuel_input_field.dart';
import 'package:flutter_labs/labs/lab1/task2/utils/fuel_oil_calculator.dart';
import 'package:flutter_labs/labs/lab1/task2/widgets/formulas_display.dart';
import 'package:flutter_labs/labs/lab1/task2/widgets/fuel_oil_calculator_results.dart';

class FuelOilCalculatorScreen extends StatefulWidget {
  const FuelOilCalculatorScreen({super.key});

  @override
  _FuelOilCalculatorScreenState createState() =>
      _FuelOilCalculatorScreenState();
}

class _FuelOilCalculatorScreenState extends State<FuelOilCalculatorScreen> {
  double carbon = 85.50;
  double hydrogen = 11.20;
  double sulfur = 2.50;
  double oxygen = 0.80;
  double moisture = 2.00;
  double ash = 0.15;
  double vanadium = 333.3;
  double lowerHeatingValueCombustible = 40.40;

  Map<String, double> workingMassResult = {};
  double lowerHeatingValueWorkingResult = 0.0;

  String? error;

  void calculate() {
    setState(() {
      try {
        workingMassResult = FuelOilCalculator.calculateWorkingMass(
          carbon,
          hydrogen,
          sulfur,
          oxygen,
          moisture,
          ash,
          vanadium,
        );
        lowerHeatingValueWorkingResult =
            FuelOilCalculator.calculateLowerHeatingValueWorking(
          lowerHeatingValueCombustible,
          moisture,
          ash,
        );
        error = null;
      } catch (e) {
        error = "Calculation error: ${e.toString()}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Fuel Oil Composition Calculator",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FuelInputField(
              label: "Carbon (C%)",
              value: carbon,
              onChanged: (val) => setState(() => carbon = val)),
          FuelInputField(
              label: "Hydrogen (H%)",
              value: hydrogen,
              onChanged: (val) => setState(() => hydrogen = val)),
          FuelInputField(
              label: "Sulfur (S%)",
              value: sulfur,
              onChanged: (val) => setState(() => sulfur = val)),
          FuelInputField(
              label: "Oxygen (O%)",
              value: oxygen,
              onChanged: (val) => setState(() => oxygen = val)),
          FuelInputField(
              label: "Moisture (W%)",
              value: moisture,
              onChanged: (val) => setState(() => moisture = val)),
          FuelInputField(
              label: "Ash (A%)",
              value: ash,
              onChanged: (val) => setState(() => ash = val)),
          FuelInputField(
              label: "Vanadium (V)",
              value: vanadium,
              onChanged: (val) => setState(() => vanadium = val)),
          FuelInputField(
            label: "Lower Heating Value (MJ/kg)",
            value: lowerHeatingValueCombustible,
            onChanged: (val) => setState(
              () => lowerHeatingValueCombustible = val,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: calculate,
            child: const Text("Calculate"),
          ),
          const SizedBox(height: 16),
          if (error != null)
            Text(
              error!,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (error == null) ...[
            FuelOilCalculatorResults(
              title: "Working Mass Results",
              results: workingMassResult,
            ),
            Text(
              "Lower Heating Value Working = ${lowerHeatingValueWorkingResult.toStringAsFixed(2)} MJ/kg",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ],
          const SizedBox(height: 16),
          const FormulasDisplay(),
        ],
      ),
    );
  }
}
