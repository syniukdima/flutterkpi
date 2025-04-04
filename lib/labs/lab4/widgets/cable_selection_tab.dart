import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab4/utils/short_circuit_calculator.dart';
import 'package:flutter_labs/labs/lab4/utils/results_entry.dart';
import 'package:flutter_labs/labs/lab4/widgets/results_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CableSelectionTab extends StatefulWidget {
  const CableSelectionTab({super.key});

  @override
  _CableSelectionTabState createState() => _CableSelectionTabState();
}

class _CableSelectionTabState extends State<CableSelectionTab> {
  final TextEditingController ikController =
      TextEditingController(text: "2500.0");
  final TextEditingController tFController = TextEditingController(text: "2.5");
  final TextEditingController smController =
      TextEditingController(text: "1300.0");
  final TextEditingController unomController =
      TextEditingController(text: "10.0");
  final TextEditingController tmController =
      TextEditingController(text: "4000.0");

  List<ResultEntry> results = [];

  void _calculate() {
    final calculator = ShortCircuitCalculator();
    final cableResults = calculator.calculateCableSelection(
      double.parse(ikController.text),
      double.parse(tFController.text),
      double.parse(smController.text),
      double.parse(unomController.text),
      double.parse(tmController.text),
    );

    setState(() {
      results = [
        ResultEntry(
            name: "Розрахунковий струм",
            value: "${cableResults['Im']} A",
            icon: FontAwesomeIcons.bolt),
        ResultEntry(
            name: "Післяаварійний струм",
            value: "${cableResults['ImPa']} A",
            icon: FontAwesomeIcons.fire),
        ResultEntry(
            name: "Економічний переріз",
            value: "${cableResults['Sek']} мм²",
            icon: FontAwesomeIcons.ruler),
        ResultEntry(
            name: "Мінімальний переріз",
            value: "${cableResults['sMin']} мм²",
            icon: FontAwesomeIcons.compress),
        ResultEntry(
            name: "Вибраний переріз",
            value: "${cableResults['finalSek']} мм²",
            icon: FontAwesomeIcons.check),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Вибір кабелю",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildTextField(ikController, "Ik (A)"),
            _buildTextField(tFController, "tФ"),
            _buildTextField(smController, "Sm (mm²)"),
            _buildTextField(unomController, "Uном"),
            _buildTextField(tmController, "Tм"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text("Розрахувати"),
            ),
            const SizedBox(height: 16),
            if (results.isNotEmpty) UnifiedResultsWidget(results: results),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
