import 'dart:math';

class ShortCircuitCalculator {
  Map<String, double> calculateCableSelection(
      double Ik, double tF, double Sm, double Unom, double Tm) {
    double Im = ((Sm / 2) / (sqrt(3) * Unom) * 100).round() / 100;
    double ImPa = (2 * Im * 100).round() / 100;

    double jEk = 1.4;
    double Sek = (Im / jEk * 100).round() / 100;

    double Ct = 92.0;
    double sMin = ((Ik * sqrt(tF)) / Ct * 100).round() / 100;
    double finalSek = sMin >= 50 ? sMin : 50.0;

    return {
      "Im": Im,
      "ImPa": ImPa,
      "Sek": Sek,
      "sMin": sMin,
      "finalSek": finalSek
    };
  }

  Map<String, double> calculateShortCircuitCurrent(double sK, double uNom) {
    double xC = ((uNom * uNom) / sK * 100).round() / 100;

    double uK = 10.5;
    double sNomT = 6.3;
    double xT = ((uK / 100) * ((uNom * uNom) / sNomT) * 100).round() / 100;

    double xTotal = ((xC + xT) * 100).round() / 100;
    double iP0 = ((uNom / (sqrt(3) * xTotal)) * 100).round() / 100;

    double sBase = 1000.0;
    double uBase = 10.0;
    double iBase = ((sBase / (sqrt(3) * uBase)) * 100).round() / 100;

    double xCBase = ((sBase / sK) * 100).round() / 100;
    double xTBase = ((uK / 100) * sBase / sNomT * 100).round() / 100;

    return {
      "X_c": xC,
      "X_t": xT,
      "X_total": xTotal,
      "I_p0": iP0,
      "I_base": iBase,
      "X_c_base": xCBase,
      "X_t_base": xTBase
    };
  }

  Map<String, double> calculateHPnEMShortCircuitCurrent(
      double Uvn,
      double Rsn,
      double Xsn,
      double Rsmin,
      double Xsmin) {
    double UvnTrans = 115.0;
    double Sn = 6.3;
    double UkMax = 11.1;

    double Xt = ((UkMax * UvnTrans * UvnTrans) / (100 * Sn) * 100).round() / 100;

    double Xsh = Xsn + Xt;
    double Zsh = (sqrt(Rsn * Rsn + Xsh * Xsh) * 100).round() / 100;

    double Ish3Normal = ((Uvn * 1000) / (sqrt(3) * Zsh) * 100).round() / 100;
    double Ish2Normal = (Ish3Normal * sqrt(3) / 2 * 100).round() / 100;

    double XshMin = Xsmin + Xt;
    double ZshMin = (sqrt(Rsmin * Rsmin + XshMin * XshMin) * 100).round() / 100;

    double Ish3Min = ((Uvn * 1000) / (sqrt(3) * ZshMin) * 100).round() / 100;
    double Ish2Min = (Ish3Min * sqrt(3) / 2 * 100).round() / 100;

    double Unn = 11.0;
    double Kpr = (Unn * Unn) / (UvnTrans * UvnTrans);

    double RshN = Rsn * Kpr;
    double XshN = Xsh * Kpr;
    double ZshN = sqrt(RshN * RshN + XshN * XshN);

    double IshN3 = (Unn * 1000) / (sqrt(3) * ZshN);
    double IshN2 = IshN3 * sqrt(3) / 2;

    double RshNMin = Rsmin * Kpr;
    double XshNMin = XshMin * Kpr;
    double ZshNMin = sqrt(RshNMin * RshNMin + XshNMin * XshNMin);

    double IshNMin3 = (Unn * 1000) / (sqrt(3) * ZshNMin);
    double IshNMin2 = IshNMin3 * sqrt(3) / 2;

    double lineLength = 12.37;
    double R0 = 0.64;
    double X0 = 0.363;

    double Rl = lineLength * R0;
    double Xl = lineLength * X0;

    double RetaN = Rl + RshN;
    double XetaN = Xl + XshN;
    double ZetaN = sqrt(RetaN * RetaN + XetaN * XetaN);

    double IlN3 = (Unn * 1000) / (sqrt(3) * ZetaN);
    double IlN2 = IlN3 * sqrt(3) / 2;

    double RetaNMin = Rl + RshNMin;
    double XetaNMin = Xl + XshNMin;
    double ZetaNMin = sqrt(RetaNMin * RetaNMin + XetaNMin * XetaNMin);

    double IlNMin3 = (Unn * 1000) / (sqrt(3) * ZetaNMin);
    double IlNMin2 = IlNMin3 * sqrt(3) / 2;

    return {
      "Xt": Xt,
      "Zsh": Zsh,
      "Ish3Normal": Ish3Normal,
      "Ish2Normal": Ish2Normal,
      "Ish3Min": Ish3Min,
      "Ish2Min": Ish2Min,
      "Kpr": Kpr,
      "ZshN": ZshN,
      "IshN3": IshN3,
      "IshN2": IshN2,
      "ZshNMin": ZshNMin,
      "IshNMin3": IshNMin3,
      "IshNMin2": IshNMin2,
      "Rl": Rl,
      "Xl": Xl,
      "ZetaN": ZetaN,
      "IlN3": IlN3,
      "IlN2": IlN2,
      "ZetaNMin": ZetaNMin,
      "IlNMin3": IlNMin3,
      "IlNMin2": IlNMin2
    };
  }
}
