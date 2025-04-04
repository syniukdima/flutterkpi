import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_labs/labs/lab5/utils/reliability_calculator.dart';
import 'package:flutter_labs/labs/lab5/widgets/custom_result_display.dart';

class ReliabilityTab extends StatefulWidget {
  @override
  _ReliabilityTabState createState() => _ReliabilityTabState();
}

class _ReliabilityTabState extends State<ReliabilityTab> {
  final ReliabilityCalculator calculator = ReliabilityCalculator();
  Map<String, double> singleCircuitReliability = {};
  double doubleCircuitReliability = 0.0;

  void calculateReliability() {
    setState(() {
      singleCircuitReliability = calculator.calculateSingleCircuitReliability();
      doubleCircuitReliability = calculator.calculateDoubleCircuitReliability();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: calculateReliability,
            child: const Text("Розрахувати надійність"),
          ),
          const SizedBox(height: 16),
          CustomResultDisplay(
            title: "Надійність одноколової системи:",
            result: singleCircuitReliability.entries
                .map((entry) => "${entry.key}: ${entry.value.toStringAsFixed(4)}")
                .join("\n"),
            icon: FontAwesomeIcons.signal,
          ),
          const SizedBox(height: 16),
          CustomResultDisplay(
            title: "Надійність двоколової системи:",
            result: doubleCircuitReliability.toStringAsFixed(4),
            icon: FontAwesomeIcons.link,
          ),
        ],
      ),
    );
  }
}
