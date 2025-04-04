class FuelCalculator {
  static double transitionCoefficientWorkingToDry(double wp) => 100 / (100 - wp);

  static double transitionCoefficientWorkingToCombustible(double wp, double ap) =>
      100 / (100 - wp - ap);

  static Map<String, double> calculateDryMass(
      double hp, double cp, double sp, double np, double op, double wp, double ap) {
    double dryFactor = transitionCoefficientWorkingToDry(wp);
    return {
      "H^С": hp * dryFactor,
      "C^С": cp * dryFactor,
      "S^С": sp * dryFactor,
      "N^С": np * dryFactor,
      "O^С": op * dryFactor,
      "A^С": ap * dryFactor,
    };
  }

  static Map<String, double> calculateCombustibleMass(
      double hp, double cp, double sp, double np, double op, double wp, double ap) {
    double combustibleFactor = transitionCoefficientWorkingToCombustible(wp, ap);
    return {
      "H^Г": hp * combustibleFactor,
      "C^Г": cp * combustibleFactor,
      "S^Г": sp * combustibleFactor,
      "N^Г": np * combustibleFactor,
      "O^Г": op * combustibleFactor,
    };
  }

  static double calculateLowerHeatingValueWorking(
      double hp, double cp, double sp, double op, double wp) {
    return ((339 * cp) + (1030 * hp) - 108.8 * (op - sp) - (25 * wp)) / 1000;
  }

  static double calculateLowerHeatingValueDry(
      double hp, double cp, double sp, double op, double wp) {
    double lhvW = calculateLowerHeatingValueWorking(hp, cp, sp, op, wp);
    return (lhvW + 0.025 * wp) * transitionCoefficientWorkingToDry(wp);
  }

  static double calculateLowerHeatingValueCombustible(
      double hp, double cp, double sp, double op, double wp, double ap) {
    double lhvW = calculateLowerHeatingValueWorking(hp, cp, sp, op, wp);
    return (lhvW + 0.025 * wp) * transitionCoefficientWorkingToCombustible(wp, ap);
  }
}
