import 'package:flutter/material.dart';

class NaturalGasForm extends StatelessWidget {
  const NaturalGasForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Калькулятор викидів природного газу",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
              "При спалюванні природного газу тверді частинки не утворюються."),
          SizedBox(height: 16),
          Text("Валові викиди: 0.0 т"),
        ],
      ),
    );
  }
}
