class LossCalculator {
  double calculateEmergencyLosses() {
    const double omega = 0.01;
    const double tV = 45e-3; // в роках
    const double Pm = 5.12e3; // потужність
    const double Tm = 6451; // година

    double expectedShortage = omega * tV * Pm * Tm;
    return (expectedShortage / 100).roundToDouble() * 100;
  }

  double calculatePlannedLosses() {
    const double kP = 4e-3;
    const double Pm = 5.12e3; // потужність
    const double Tm = 6451; // година

    return (kP * Pm * Tm / 100).roundToDouble() * 100;
  }

  double calculateTotalLosses(double emergencyRate, double plannedRate) {
    double M_WnedA = calculateEmergencyLosses();
    double M_WnedP = calculatePlannedLosses();
    return (emergencyRate * M_WnedA) + (plannedRate * M_WnedP);
  }
}

void main() {
  final lossCalculator = LossCalculator();

  double emergencyRate = 23.6; // грн./кВт-год.
  double plannedRate = 17.6; // грн./кВт-год.
  double totalLosses = lossCalculator.calculateTotalLosses(emergencyRate, plannedRate);

  print("Загальні збитки від перерв електропостачання: $totalLosses грн.");
}
