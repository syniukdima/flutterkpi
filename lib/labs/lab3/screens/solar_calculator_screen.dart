import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab3/utils/solar_calculator.dart';

class SolarCalculatorScreen extends StatefulWidget {
  const SolarCalculatorScreen({super.key});

  @override
  _SolarCalculatorScreenState createState() => _SolarCalculatorScreenState();
}

class _SolarCalculatorScreenState extends State<SolarCalculatorScreen> {
  final _averagePowerController = TextEditingController(text: '5.0');
  final _pricePerKWhController = TextEditingController(text: '0.007');
  final _initialSigmaController = TextEditingController(text: '1.0');
  final _improvedSigmaController = TextEditingController(text: '0.25');
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTextField("Average Power (MW)", _averagePowerController),
          _buildTextField("Price per kWh (UAH)", _pricePerKWhController),
          _buildTextField("Initial Sigma (MW)", _initialSigmaController),
          _buildTextField("Improved Sigma (MW)", _improvedSigmaController),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _calculateProfit,
            child: const Text("Calculate"),
          ),
          const SizedBox(height: 16),
          Text(
            result,
            style: const TextStyle(fontSize: 18, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _calculateProfit() {
    double averagePower = double.parse(_averagePowerController.text);
    double pricePerKWh = double.parse(_pricePerKWhController.text);
    double initialSigma = double.parse(_initialSigmaController.text);
    double improvedSigma = double.parse(_improvedSigmaController.text);

    SolarPowerStation station = SolarPowerStation(
      averagePower: averagePower,
      pricePerKWh: pricePerKWh,
      initialSigma: initialSigma,
      improvedSigma: improvedSigma,
    );

    double profit = SolarCalculator.calculateProfit(station);
    setState(() {
      result =
          'Profit after system improvement: ${profit.toStringAsFixed(2)} thousand UAH';
    });
  }
}
