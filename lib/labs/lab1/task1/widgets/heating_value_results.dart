import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeatingValueResults extends StatelessWidget {
  final double lowerHeatingValueResult;
  final double lowerHeatingValueResultDry;
  final double lowerHeatingValueResultCombustible;

  const HeatingValueResults({
    super.key,
    required this.lowerHeatingValueResult,
    required this.lowerHeatingValueResultDry,
    required this.lowerHeatingValueResultCombustible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildResultCard(
          icon: FontAwesomeIcons.fire,
          label: "Working",
          value: lowerHeatingValueResult,
          color: Colors.orange,
        ),
        _buildResultCard(
          icon: FontAwesomeIcons.wind,
          label: "Dry",
          value: lowerHeatingValueResultDry,
          color: Colors.blue,
        ),
        _buildResultCard(
          icon: FontAwesomeIcons.burn,
          label: "Combustible",
          value: lowerHeatingValueResultCombustible,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildResultCard({
    required IconData icon,
    required String label,
    required double value,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Lower Heating Value ($label): ${value.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
