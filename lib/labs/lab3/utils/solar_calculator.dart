import 'dart:math';

class SolarPowerStation {
  final double averagePower; // середньодобова потужність (МВт)
  final double pricePerKWh;  // вартість електроенергії (грн/кВт-год)
  final double initialSigma; // початкова похибка (МВт)
  final double improvedSigma; // покращена похибка (МВт)

  SolarPowerStation({
    required this.averagePower,
    required this.pricePerKWh,
    required this.initialSigma,
    required this.improvedSigma,
  });
}

class SolarCalculator {
  static double calculateEnergyPortion(
      double sigma, double pc, double range) {
    double lowerBound = pc - range;
    double upperBound = pc + range;
    double result = 0.5 *
        (erf((upperBound - pc) / (sigma * sqrt(2))) -
            erf((lowerBound - pc) / (sigma * sqrt(2))));
    return double.parse(result.toStringAsFixed(2));
  }

  static double calculateProfit(SolarPowerStation station) {
    const hoursInDay = 24;

    double deltaW1 =
    calculateEnergyPortion(station.initialSigma, station.averagePower, 0.25);
    double W1 = station.averagePower * hoursInDay * deltaW1; // Without imbalance
    double W2 = station.averagePower * hoursInDay * (1 - deltaW1); // With imbalance
    double P1 = W1 * station.pricePerKWh * 1000; // Profit for non-imbalanced energy
    double S1 = W2 * station.pricePerKWh * 1000; // Penalty for imbalanced energy
    double profitBefore = P1 - S1;

    double deltaW2 =
    calculateEnergyPortion(station.improvedSigma, station.averagePower, 0.25);
    double W3 = station.averagePower * hoursInDay * deltaW2; // Without imbalance
    double W4 = station.averagePower * hoursInDay * (1 - deltaW2); // With imbalance
    double P2 = W3 * station.pricePerKWh * 1000; // Profit for non-imbalanced energy
    double S2 = W4 * station.pricePerKWh * 1000; // Penalty for imbalanced energy
    double profitAfter = P2 - S2;

    return profitAfter;
  }

  static double erf(double x) {
    double t = 1.0 / (1.0 + 0.5 * x.abs());
    double tau = t *
        exp(-x * x - 1.26551223 +
            t * (1.00002368 +
                t * (0.37409196 +
                    t * (0.09678418 +
                        t * (-0.18628806 +
                            t * (0.27886807 +
                                t * (-1.13520398 +
                                    t * (1.48851587 +
                                        t * (-0.82215223 +
                                            t * 0.17087277)))))))));
    return x >= 0 ? 1 - tau : tau - 1;
  }
}
