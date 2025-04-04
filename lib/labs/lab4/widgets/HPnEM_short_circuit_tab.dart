import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab4/utils/short_circuit_calculator.dart';
import 'package:flutter_labs/labs/lab4/utils/results_entry.dart';
import 'package:flutter_labs/labs/lab4/widgets/results_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HPnEMShortCircuitTab extends StatefulWidget {
  const HPnEMShortCircuitTab({super.key});

  @override
  _HPnEMShortCircuitTabState createState() => _HPnEMShortCircuitTabState();
}

class _HPnEMShortCircuitTabState extends State<HPnEMShortCircuitTab> {
  final TextEditingController uvnController =
      TextEditingController(text: "115.0");
  final TextEditingController rsnController =
      TextEditingController(text: "10.65");
  final TextEditingController xsnController =
      TextEditingController(text: "24.02");
  final TextEditingController rsminController =
      TextEditingController(text: "34.88");
  final TextEditingController xsminController =
      TextEditingController(text: "65.68");

  List<ResultEntry> results = [];

  void _calculate() {
    var calculator = ShortCircuitCalculator();
    var resultData = calculator.calculateHPnEMShortCircuitCurrent(
      double.parse(uvnController.text),
      double.parse(rsnController.text),
      double.parse(xsnController.text),
      double.parse(rsminController.text),
      double.parse(xsminController.text),
    );

    setState(
      () {
        results = [
          ResultEntry(
              name: "Реактивний опір трансформатора (Xt)",
              value: resultData["Xt"]!.toStringAsFixed(2),
              icon: FontAwesomeIcons.bolt),
          ResultEntry(
              name: "Загальний опір (Zш)",
              value: resultData["Zsh"]!.toStringAsFixed(2),
              icon: FontAwesomeIcons.handFist),
          ResultEntry(
              name: "Струм трифазного КЗ (Ish3Normal)",
              value: resultData["Ish3Normal"]!.toStringAsFixed(2),
              icon: FontAwesomeIcons.lightbulb),
          ResultEntry(
              name: "Струм двофазного КЗ (Ish2Normal)",
              value: resultData["Ish2Normal"]!.toStringAsFixed(2),
              icon: FontAwesomeIcons.boltLightning),
          ResultEntry(
              name: "Мінімальний струм трифазного КЗ (Ish3Min)",
              value: resultData["Ish3Min"]!.toStringAsFixed(2),
              icon: FontAwesomeIcons.hand),
          ResultEntry(
              name: "Мінімальний струм двофазного КЗ (Ish2Min)",
              value: resultData["Ish2Min"]!.toStringAsFixed(2),
              icon: FontAwesomeIcons.lightbulb),
          ResultEntry(
              name: "Коефіцієнт перерахунку (Kpr)",
              value: resultData["Kpr"]!.toStringAsFixed(2),
              icon: FontAwesomeIcons.exchangeAlt),
          ResultEntry(
              name: "Загальний опір з перерахунком (ZshN)",
              value: resultData["ZshN"]!.toStringAsFixed(2),
              icon: FontAwesomeIcons.calculator),
          ResultEntry(
              name: "Струм трифазного КЗ (IshN3)",
              value: resultData["IshN3"]!.toStringAsFixed(2),
              icon: FontAwesomeIcons.bolt),
          ResultEntry(
              name: "Струм двофазного КЗ (IshN2)",
              value: resultData["IshN2"]!.toStringAsFixed(2),
              icon: FontAwesomeIcons.boltLightning),
        ];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Розрахунок КЗ для ХПнЕМ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            _buildTextField(uvnController, "Uvn (кВ)"),
            _buildTextField(rsnController, "Rsn (Ом)"),
            _buildTextField(xsnController, "Xsn (Ом)"),
            _buildTextField(rsminController, "Rsmin (Ом)"),
            _buildTextField(xsminController, "Xsmin (Ом)"),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: _calculate, child: const Text("Розрахувати")),
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
