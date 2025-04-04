class ReliabilityCalculator {
  Map<String, double> calculateSingleCircuitReliability() {
    List<double> failureRates = [0.01, 0.07, 0.015, 0.02, 0.03 * 6];
    double omegaOs = failureRates.reduce((a, b) => a + b);

    double averageRepairTime = (0.01 * 30 + 0.07 * 10 + 0.015 * 100 + 0.02 * 15 + 0.18 * 2) / omegaOs;
    double kAoc = (omegaOs * averageRepairTime) / 8760;
    double kPos = 1.2 * 43 / 8760;

    return {
      "omegaOs": omegaOs,
      "averageRepairTime": averageRepairTime,
      "kAoc": kAoc,
      "kPos": kPos
    };
  }

  double calculateDoubleCircuitReliability() {
    Map<String, double> singleCircuitReliability = calculateSingleCircuitReliability();

    double omegaDk = 2 * singleCircuitReliability["omegaOs"]! *
        (singleCircuitReliability["kAoc"]! + singleCircuitReliability["kPos"]!);
    double omegaDs = omegaDk + 0.02;

    return double.parse(omegaDs.toStringAsFixed(4));
  }
}

void main() {
  final reliabilityCalculator = ReliabilityCalculator();

  Map<String, double> singleCircuitReliability = reliabilityCalculator.calculateSingleCircuitReliability();
  double doubleCircuitReliability = reliabilityCalculator.calculateDoubleCircuitReliability();

  print("Надійність одноколової системи: $singleCircuitReliability");
  print("Надійність двоколової системи: $doubleCircuitReliability");
}
