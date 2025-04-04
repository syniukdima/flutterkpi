import 'dart:math';

class ElectricalLoad {
  final String name;
  final double nominalEfficiency;
  final double powerFactor;
  final double nominalVoltage;
  final int count;
  final double nominalPower;
  final double usageCoefficient;
  final double? reactivePowerCoefficient;

  ElectricalLoad({
    required this.name,
    required this.nominalEfficiency,
    required this.powerFactor,
    required this.nominalVoltage,
    required this.count,
    required this.nominalPower,
    required this.usageCoefficient,
    this.reactivePowerCoefficient,
  });
}

class ShopLoad {
  final int overallCount;
  final double overallNominalPowerByCount;
  final double overallNominalPowerByCountByUsageCoefficient;
  final double overallNominalPowerByCountByCoefficients;
  final double overallSquaredNominalPowerByCount;

  ShopLoad({
    required this.overallCount,
    required this.overallNominalPowerByCount,
    required this.overallNominalPowerByCountByUsageCoefficient,
    required this.overallNominalPowerByCountByCoefficients,
    required this.overallSquaredNominalPowerByCount,
  });
}

class LoadCalculator {
  static double calculateLoadCurrent(ElectricalLoad load) {
    double totalPower = load.count * load.nominalPower;
    return totalPower /
        (sqrt(3) * load.nominalVoltage * load.powerFactor * load.nominalEfficiency);
  }

  static double calculateGroupUsageCoefficient(List<ElectricalLoad> loads) {
    double totalPower = loads.fold(0.0, (sum, load) =>
    sum + load.count * load.nominalPower * load.usageCoefficient);
    double totalNominalPower = loads.fold(0.0, (sum, load) =>
    sum + load.count * load.nominalPower);
    return double.parse((totalPower / totalNominalPower).toStringAsFixed(4));
  }

  static double calculateEffectiveCount(List<ElectricalLoad> loads) {
    double sumNominalPowerSquared = loads.fold(0.0, (sum, load) =>
    sum + (load.count * load.nominalPower));
    double totalNominalPower = loads.fold(0.0, (sum, load) =>
    sum + load.count * pow(load.nominalPower, 2));
    return double.parse((pow(sumNominalPowerSquared, 2) / totalNominalPower)
        .toStringAsFixed(4));
  }

  static double calculateActiveLoadPower(double groupUsageCoefficient, double effectiveLoadPower) {
    const double activePowerCoefficient = 1.25;
    double activeLoadPower = activePowerCoefficient *
        groupUsageCoefficient *
        effectiveLoadPower;
    return double.parse(activeLoadPower.toStringAsFixed(2));
  }

  static double calculateTotalReactiveLoadPower(List<ElectricalLoad> loads) {
    double totalReactivePower = loads.fold(0.0, (sum, load) {
      if (load.reactivePowerCoefficient == null ||
          load.reactivePowerCoefficient == 0.0) {
        return sum;
      } else {
        return sum + load.count *
            load.usageCoefficient *
            load.nominalPower *
            load.reactivePowerCoefficient!;
      }
    });
    return double.parse(totalReactivePower.toStringAsFixed(3));
  }

  static double calculateTotalPower(double activePower, double reactivePower) {
    return double.parse(sqrt(pow(activePower, 2) + pow(reactivePower, 2))
        .toStringAsFixed(4));
  }

  static double calculateGroupCurrent(double totalPower, double nominalVoltage) {
    return double.parse((totalPower / nominalVoltage).toStringAsFixed(2));
  }

  static double calculateGroupUsageCoefficientFull(ShopLoad load) {
    double result =
        load.overallNominalPowerByCountByUsageCoefficient /
            load.overallNominalPowerByCount;
    return double.parse(result.toStringAsFixed(2));
  }

  static int calculateEffectiveCountFull(ShopLoad load) {
    return (pow(load.overallNominalPowerByCount, 2) /
        load.overallSquaredNominalPowerByCount)
        .toInt();
  }

  static double calculateOverallActiveLoadPower(ShopLoad load) {
    const double activePowerCoefficient = 0.7;
    return double.parse((activePowerCoefficient *
        load.overallNominalPowerByCountByUsageCoefficient)
        .toStringAsFixed(1));
  }

  static double calculateOverallReactiveLoadPower(ShopLoad load) {
    const double activePowerCoefficient = 0.7;
    return double.parse((activePowerCoefficient *
        load.overallNominalPowerByCountByCoefficients)
        .toStringAsFixed(1));
  }
}

void main() {
  List<ElectricalLoad> loads = [
    ElectricalLoad(name: "Шліфувальний верстат", nominalEfficiency: 0.92, powerFactor: 0.9, nominalVoltage: 0.38, count: 4, nominalPower: 20.0, usageCoefficient: 0.15, reactivePowerCoefficient: 1.33),
    ElectricalLoad(name: "Свердлильний верстат", nominalEfficiency: 0.92, powerFactor: 0.9, nominalVoltage: 0.38, count: 2, nominalPower: 14.0, usageCoefficient: 0.12, reactivePowerCoefficient: 1.0),
    ElectricalLoad(name: "Фугувальний верстат", nominalEfficiency: 0.92, powerFactor: 0.9, nominalVoltage: 0.38, count: 4, nominalPower: 42.0, usageCoefficient: 0.15, reactivePowerCoefficient: 1.33),
    ElectricalLoad(name: "Циркулярна пила", nominalEfficiency: 0.92, powerFactor: 0.9, nominalVoltage: 0.38, count: 1, nominalPower: 36.0, usageCoefficient: 0.3, reactivePowerCoefficient: 1.52),
    ElectricalLoad(name: "Прес", nominalEfficiency: 0.92, powerFactor: 0.9, nominalVoltage: 0.38, count: 1, nominalPower: 20.0, usageCoefficient: 0.5, reactivePowerCoefficient: 0.75),
    ElectricalLoad(name: "Полірувальний верстат", nominalEfficiency: 0.92, powerFactor: 0.9, nominalVoltage: 0.38, count: 1, nominalPower: 40.0, usageCoefficient: 0.2, reactivePowerCoefficient: 1.0),
    ElectricalLoad(name: "Фрезерний верстат", nominalEfficiency: 0.92, powerFactor: 0.9, nominalVoltage: 0.38, count: 2, nominalPower: 32.0, usageCoefficient: 0.2, reactivePowerCoefficient: 1.0),
    ElectricalLoad(name: "Вентилятор", nominalEfficiency: 0.92, powerFactor: 0.9, nominalVoltage: 0.38, count: 1, nominalPower: 20.0, usageCoefficient: 0.65, reactivePowerCoefficient: 0.75)
  ];

  for (var load in loads) {
    double current = LoadCalculator.calculateLoadCurrent(load);
    print("Розрахунковий струм для ${load.name}: $current А");
  }

  double groupUsageCoefficient = LoadCalculator.calculateGroupUsageCoefficient(loads);
  double effectiveCount = LoadCalculator.calculateEffectiveCount(loads);
  print("Груповий коефіцієнт використання: $groupUsageCoefficient");
  print("Ефективна кількість ЕП: $effectiveCount");

  double effectiveLoadPower = loads.fold(0.0, (sum, load) => sum + (load.nominalPower * load.count));
  double activePower = LoadCalculator.calculateActiveLoadPower(groupUsageCoefficient, effectiveLoadPower);
  double reactivePower = LoadCalculator.calculateTotalReactiveLoadPower(loads);
  double totalPower = LoadCalculator.calculateTotalPower(activePower, reactivePower);
  double groupCurrent = LoadCalculator.calculateGroupCurrent(activePower, loads[0].nominalVoltage);

  print("Загальне активне навантаження: $activePower кВт");
  print("Загальне реактивне навантаження: $reactivePower квар");
  print("Загальна потужність: $totalPower кВА");
  print("Груповий струм: $groupCurrent А");
}
