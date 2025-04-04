import 'package:flutter/material.dart';

class EmissionInputField extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  const EmissionInputField({super.key, required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
        controller: TextEditingController(text: value),
      ),
    );
  }
}
