import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab4/utils/short_circuit_calculator.dart';
import 'package:flutter_labs/labs/lab4/utils/results_entry.dart';
import 'package:flutter_labs/labs/lab4/widgets/results_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShortCircuitTab extends StatefulWidget {
  const ShortCircuitTab({super.key});

  @override
  _ShortCircuitTabState createState() => _ShortCircuitTabState();
}

class _ShortCircuitTabState extends State<ShortCircuitTab> {
  final TextEditingController skController =
      TextEditingController(text: "200.0");
  final TextEditingController unomController =
      TextEditingController(text: "10.5");

  List<ResultEntry> results = [];

  void _calculate() {
    double sk = double.parse(skController.text);
    double unom = double.parse(unomController.text);

    var calculator = ShortCircuitCalculator();
    var resultData = calculator.calculateShortCircuitCurrent(sk, unom);

    setState(() {
      results = [
        ResultEntry(
            name: "Опір короткого замикання (Xc)",
            value: resultData["X_c"].toString(),
            icon: FontAwesomeIcons.bolt),
        ResultEntry(
            name: "Опір трансформатора (Xt)",
            value: resultData["X_t"].toString(),
            icon: FontAwesomeIcons.handFist),
        ResultEntry(
            name: "Сумарний опір (X_total)",
            value: resultData["X_total"].toString(),
            icon: FontAwesomeIcons.calculator),
        ResultEntry(
            name: "Початковий струм КЗ (Ip0)",
            value: resultData["I_p0"].toString(),
            icon: FontAwesomeIcons.lightbulb),
        ResultEntry(
            name: "Базовий струм (I_base)",
            value: resultData["I_base"].toString(),
            icon: FontAwesomeIcons.batteryFull),
        ResultEntry(
            name: "Базовий опір короткого замикання (Xc_base)",
            value: resultData["X_c_base"].toString(),
            icon: FontAwesomeIcons.boltLightning),
        ResultEntry(
            name: "Базовий опір трансформатора (Xt_base)",
            value: resultData["X_t_base"].toString(),
            icon: FontAwesomeIcons.exchangeAlt),
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
              const Text("Розрахунок короткого замикання",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _buildTextField(skController, "S_k (кВар)"),
              _buildTextField(unomController, "U_nom (кВ)"),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: _calculate, child: const Text("Розрахувати")),
              const SizedBox(height: 16),
              if (results.isNotEmpty) UnifiedResultsWidget(results: results),
            ],
          ),
        ));
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
