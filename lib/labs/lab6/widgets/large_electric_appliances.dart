import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab6/utils/load_calculator.dart';
import 'package:flutter_labs/labs/lab6/widgets/electrical_load.dart';
import 'package:flutter_labs/labs/lab6/widgets/group_calculations.dart';

class LargeElectricAppliancesTab extends StatelessWidget {
  final loads = [
    ElectricalLoad(
      name: "Зварювальний трансформатор",
      nominalEfficiency: 0.92,
      powerFactor: 0.9,
      nominalVoltage: 0.38,
      count: 2,
      nominalPower: 100.0,
      usageCoefficient: 0.2,
      reactivePowerCoefficient: 3.0,
    ),
    ElectricalLoad(
      name: "Сушильна шафа",
      nominalEfficiency: 0.92,
      powerFactor: 0.9,
      nominalVoltage: 0.38,
      count: 2,
      nominalPower: 120.0,
      usageCoefficient: 0.8,
      reactivePowerCoefficient: null,
    ),
  ];

  LargeElectricAppliancesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
