class FuelOilCalculator {
  static Map<String, double> calculateWorkingMass(
      double carbon, double hydrogen, double sulfur, double oxygen,
      double moisture, double ash, double vanadium) {
    double factor = (100 - moisture - ash) / 100;
    return {
      "C^Р": carbon * factor,
      "H^Р": hydrogen * factor,
      "S^Р": sulfur * factor,
      "O^Р": oxygen * factor,
      "A^Р": ash,
      "V^Р": vanadium * (100 - moisture) / 100
    };
  }

  static double calculateLowerHeatingValueWorking(
      double lowerHeatingValueCombustible, double moisture, double ash) {
    double factor = (100 - moisture - ash) / 100;
    return lowerHeatingValueCombustible * factor - 0.025 * moisture;
  }
}
