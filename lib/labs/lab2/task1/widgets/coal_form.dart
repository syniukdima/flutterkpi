import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab2/task1/utils/emission_calculator.dart';
import 'package:flutter_labs/labs/lab2/task1/widgets/emission_input_field.dart';

class CoalForm extends StatefulWidget {
  final void Function(double) onCalculationUpdated;

  const CoalForm({super.key, required this.onCalculationUpdated});

  @override
  _CoalFormState createState() => _CoalFormState();
}

class _CoalFormState extends State<CoalForm> {
  final _formKey = GlobalKey<FormState>();

  String coalQr = "20.47";
  String coalAvin = "0.8";
  String coalAr = "25.20";
  String coalGvin = "1.5";
  String coalNuz = "0.985";
  String coalMass = "1096363.0";
  double result = 0.0;

  void calculateEmissions() {
    setState(() {
      result = EmissionCalculator.calculateCoalEmissions(
        qr: double.parse(coalQr),
        avin: double.parse(coalAvin),
        ar: double.parse(coalAr),
        gvin: double.parse(coalGvin),
        nuz: double.parse(coalNuz),
        coalMass: double.parse(coalMass),
      );
      widget.onCalculationUpdated(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Калькулятор викидів вугілля",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            EmissionInputField(
              label: "Qr вугілля (МДж/кг)",
              value: coalQr,
              onChanged: (v) => coalQr = v,
            ),
            EmissionInputField(
              label: "Avin вугілля",
              value: coalAvin,
              onChanged: (v) => coalAvin = v,
            ),
            EmissionInputField(
              label: "Ar вугілля (%)",
              value: coalAr,
              onChanged: (v) => coalAr = v,
            ),
            EmissionInputField(
              label: "Gvin вугілля (%)",
              value: coalGvin,
              onChanged: (v) => coalGvin = v,
            ),
            EmissionInputField(
              label: "Nuz вугілля",
              value: coalNuz,
              onChanged: (v) => coalNuz = v,
            ),
            EmissionInputField(
              label: "Маса вугілля (т)",
              value: coalMass,
              onChanged: (v) => coalMass = v,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateEmissions,
              child: const Text("Розрахувати"),
            ),
            const SizedBox(height: 20),
            Text(
              "Валові викиди вугілля: ${result.toStringAsFixed(2)} т",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
