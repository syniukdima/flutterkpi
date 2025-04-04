import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab6/utils/load_calculator.dart';


class GroupCalculationsComponent extends StatelessWidget {
  final List<ElectricalLoad> loads;

  const GroupCalculationsComponent({Key? key, required this.loads}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupUsageCoefficient = LoadCalculator.calculateGroupUsageCoefficient(loads);
    final effectiveCount = LoadCalculator.calculateEffectiveCount(loads);
    final effectiveLoadPower = loads.fold(0.0, (sum, load) => sum + (load.nominalPower * load.count));
    final activePower = LoadCalculator.calculateActiveLoadPower(groupUsageCoefficient, effectiveLoadPower);
    final reactivePower = LoadCalculator.calculateTotalReactiveLoadPower(loads);
    final totalPower = LoadCalculator.calculateTotalPower(activePower, reactivePower);
    final groupCurrent = LoadCalculator.calculateGroupCurrent(activePower, loads[0].nominalVoltage);

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Групові розрахунки', style: Theme.of(context).textTheme.bodyMedium),
            Text('Груповий коефіцієнт використання: $groupUsageCoefficient'),
            Text('Ефективна кількість приладів: $effectiveCount'),
            Text('Загальне активне навантаження: $activePower кВт'),
            Text('Загальне реактивне навантаження: $reactivePower квар'),
            Text('Загальна потужність: $totalPower кВА'),
            Text('Груповий струм: $groupCurrent А'),
          ],
        ),
      ),
    );
  }
}
