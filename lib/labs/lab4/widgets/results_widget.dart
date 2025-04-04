import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab4/utils/results_entry.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class UnifiedResultsWidget extends StatelessWidget {
  final List<ResultEntry> results;

  const UnifiedResultsWidget({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Результати розрахунку",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...results.map((entry) => _buildResultRow(entry)),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(ResultEntry entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          FaIcon(entry.icon, size: 20, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              entry.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            "${entry.value}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
