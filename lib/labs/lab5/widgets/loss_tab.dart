import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_labs/labs/lab5/utils/loss_calculator.dart';
import 'package:flutter_labs/labs/lab5/widgets/custom_text_field.dart';
import 'package:flutter_labs/labs/lab5/widgets/custom_result_display.dart';

class LossTab extends StatefulWidget {
  @override
  _LossTabState createState() => _LossTabState();
}

class _LossTabState extends State<LossTab> {
  final TextEditingController emergencyRateController =
  TextEditingController(text: "23.6");
  final TextEditingController plannedRateController =
  TextEditingController(text: "17.6");

  double totalLosses = 0.0;
  final LossCalculator calculator = LossCalculator();

  void calculateLosses() {
    double emergencyRate = double.tryParse(emergencyRateController.text) ?? 0.0;
    double plannedRate = double.tryParse(plannedRateController.text) ?? 0.0;
    setState(() {
      totalLosses = calculator.calculateTotalLosses(emergencyRate, plannedRate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomTextField(
              label: "Тариф за аварійні вимкнення (грн./кВт-год.)",
              controller: emergencyRateController),
          const SizedBox(height: 16),
          CustomTextField(
              label: "Тариф за планові вимкнення (грн./кВт-год.)",
              controller: plannedRateController),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: calculateLosses,
            child: const Text("Розрахувати збитки"),
          ),
          const SizedBox(height: 16),
          CustomResultDisplay(
            title: "Загальні збитки:",
            result: "${totalLosses.toStringAsFixed(2)} грн.",
            icon: FontAwesomeIcons.coins,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
