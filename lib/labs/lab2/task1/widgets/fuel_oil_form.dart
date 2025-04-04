import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab2/task1/utils/emission_calculator.dart';
import 'package:flutter_labs/labs/lab2/task1/widgets/emission_input_field.dart';

class FuelOilForm extends StatefulWidget {
  final void Function(double) onCalculationUpdated;

  const FuelOilForm({super.key, required this.onCalculationUpdated});

  @override
  _FuelOilFormState createState() => _FuelOilFormState();
}

class _FuelOilFormState extends State<FuelOilForm> {
  final _formKey = GlobalKey<FormState>();

  double fuelOilQr = 39.48;
  double fuelOilAvin = 1.0;
  double fuelOilAr = 0.15;
  double fuelOilGvin = 0.0;
  double fuelOilNuz = 0.985;
  double fuelOilMass = 70945.0;
  double emissions = 0.0;

  void _calculateEmissions() {
    emissions = EmissionCalculator.calculateFuelOilEmissions(
        qr: fuelOilQr,
        avin: fuelOilAvin,
        ar: fuelOilAr,
        gvin: fuelOilGvin,
        nuz: fuelOilNuz,
        fuelOilMass: fuelOilMass);
    widget.onCalculationUpdated(emissions);
    setState(() {});
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
            EmissionInputField(
              label: "Qr мазуту (МДж/кг)",
              value: fuelOilQr.toString(),
              onChanged: (value) {
                fuelOilQr = double.tryParse(value) ?? 39.48;
              },
            ),
            EmissionInputField(
              label: "Avin мазуту",
              value: fuelOilAvin.toString(),
              onChanged: (value) {
                fuelOilAvin = double.tryParse(value) ?? 1.0;
              },
            ),
            EmissionInputField(
              label: "Ar мазуту (%)",
              value: fuelOilAr.toString(),
              onChanged: (value) {
                fuelOilAr = double.tryParse(value) ?? 0.15;
              },
            ),
            EmissionInputField(
              label: "Gvin мазуту (%)",
              value: fuelOilGvin.toString(),
              onChanged: (value) {
                fuelOilGvin = double.tryParse(value) ?? 0.0;
              },
            ),
            EmissionInputField(
              label: "Nuz мазуту",
              value: fuelOilNuz.toString(),
              onChanged: (value) {
                fuelOilNuz = double.tryParse(value) ?? 0.985;
              },
            ),
            EmissionInputField(
              label: "Маса мазуту (т)",
              value: fuelOilMass.toString(),
              onChanged: (value) {
                fuelOilMass = double.tryParse(value) ?? 70945.0;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateEmissions,
              child: const Text('Розрахувати'),
            ),
            const SizedBox(height: 20),
            Text(
              "Валові викиди мазуту: ${emissions.toStringAsFixed(2)} т",
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
