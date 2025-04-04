import 'package:flutter/material.dart';

import 'package:flutter_labs/labs/lab6/utils/load_calculator.dart';
import 'package:flutter_labs/labs/lab6/widgets/electrical_load.dart';
import 'package:flutter_labs/labs/lab6/widgets/group_calculations.dart';

class ElectricAppliancesTab extends StatelessWidget {
  final List<ElectricalLoad> loads = [
    ElectricalLoad(
        name: "Шліфувальний верстат",
        nominalEfficiency: 0.92,
        powerFactor: 0.9,
        nominalVoltage: 0.38,
        count: 4,
        nominalPower: 20.0,
        usageCoefficient: 0.15,
        reactivePowerCoefficient: 1.33),
    ElectricalLoad(
        name: "Свердлильний верстат",
        nominalEfficiency: 0.92,
        powerFactor: 0.9,
        nominalVoltage: 0.38,
        count: 2,
        nominalPower: 14.0,
        usageCoefficient: 0.12,
        reactivePowerCoefficient: 1.0),
    ElectricalLoad(
        name: "Фугувальний верстат",
        nominalEfficiency: 0.92,
        powerFactor: 0.9,
        nominalVoltage: 0.38,
        count: 4,
        nominalPower: 42.0,
        usageCoefficient: 0.15,
        reactivePowerCoefficient: 1.33),
    ElectricalLoad(
        name: "Циркулярна пила",
        nominalEfficiency: 0.92,
        powerFactor: 0.9,
        nominalVoltage: 0.38,
        count: 1,
        nominalPower: 36.0,
        usageCoefficient: 0.3,
        reactivePowerCoefficient: 1.52),
    ElectricalLoad(
        name: "Прес",
        nominalEfficiency: 0.92,
        powerFactor: 0.9,
        nominalVoltage: 0.38,
        count: 1,
        nominalPower: 20.0,
        usageCoefficient: 0.5,
        reactivePowerCoefficient: 0.75),
    ElectricalLoad(
        name: "Полірувальний верстат",
        nominalEfficiency: 0.92,
        powerFactor: 0.9,
        nominalVoltage: 0.38,
        count: 1,
        nominalPower: 40.0,
        usageCoefficient: 0.2,
        reactivePowerCoefficient: 1.0),
    ElectricalLoad(
        name: "Фрезерний верстат",
        nominalEfficiency: 0.92,
        powerFactor: 0.9,
        nominalVoltage: 0.38,
        count: 2,
        nominalPower: 32.0,
        usageCoefficient: 0.2,
        reactivePowerCoefficient: 1.0),
    ElectricalLoad(
        name: "Вентилятор",
        nominalEfficiency: 0.92,
        powerFactor: 0.9,
        nominalVoltage: 0.38,
        count: 1,
        nominalPower: 20.0,
        usageCoefficient: 0.65,
        reactivePowerCoefficient: 0.75)
  ];

  ElectricAppliancesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Групи приладів",
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            ...loads.map((load) {
              double current = LoadCalculator.calculateLoadCurrent(load);
              return ElectricalLoadCard(load: load, current: current);
            }),
            const SizedBox(height: 16),
            GroupCalculationsComponent(loads: loads),
          ],
        ),
      ),
    );
  }
}
