import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab6/utils/load_calculator.dart';

class ElectricalLoadCard extends StatelessWidget {
  final ElectricalLoad load;
  final double current;

  const ElectricalLoadCard({
    super.key,
    required this.load,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Прилад: ${load.name}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "Номінальна напруга: ${load.nominalVoltage} кВ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "Номінальна потужність: ${load.nominalPower} кВт",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "Коефіцієнт використання: ${load.usageCoefficient}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "Коефіцієнт реактивної потужності: ${load.reactivePowerCoefficient}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              "Розрахунковий струм: ${current.toStringAsFixed(3)} А",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
