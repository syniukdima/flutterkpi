import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab2/task1/widgets/coal_form.dart';
import 'package:flutter_labs/labs/lab2/task1/widgets/fuel_oil_form.dart';
import 'package:flutter_labs/labs/lab2/task1/widgets/natural_gas_form.dart';

class EmissionCalculatorScreen extends StatefulWidget {
  const EmissionCalculatorScreen({super.key});

  @override
  _EmissionCalculatorScreenState createState() =>
      _EmissionCalculatorScreenState();
}

class _EmissionCalculatorScreenState extends State<EmissionCalculatorScreen> {
  double totalEmissions = 0.0;

  void _updateTotalEmissions(double newEmission) {
    setState(() {
      totalEmissions = newEmission;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Вугілля"),
              Tab(text: "Мазут"),
              Tab(text: "Природний газ"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Загальні викиди CO₂: ${totalEmissions.toStringAsFixed(2)} т",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                CoalForm(onCalculationUpdated: _updateTotalEmissions),
                FuelOilForm(onCalculationUpdated: _updateTotalEmissions),
                const NaturalGasForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
