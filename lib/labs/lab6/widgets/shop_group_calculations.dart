import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab6/utils/load_calculator.dart';


class ShopResultCard extends StatelessWidget {
  final String title;
  final String result;

  const ShopResultCard({super.key, required this.title, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 4.0),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShopGroupCalculationsComponent extends StatelessWidget {
  const ShopGroupCalculationsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final shopLoad = ShopLoad(
      overallCount: 81,
      overallNominalPowerByCount: 2330.0,
      overallNominalPowerByCountByUsageCoefficient: 752.0,
      overallNominalPowerByCountByCoefficients: 657.0,
      overallSquaredNominalPowerByCount: 96399.0,
    );

    final fullUsageCoefficientLarge = LoadCalculator.calculateGroupUsageCoefficientFull(shopLoad);
    final effectiveLoadPowerFull = LoadCalculator.calculateEffectiveCountFull(shopLoad);
    final overallActivePower = LoadCalculator.calculateOverallActiveLoadPower(shopLoad);
    final overallReactivePower = LoadCalculator.calculateOverallReactiveLoadPower(shopLoad);
    final overallShopPower = LoadCalculator.calculateTotalPower(overallActivePower, overallReactivePower);
    final overallGroupCurrent = LoadCalculator.calculateGroupCurrent(overallActivePower, 0.38);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Результати розрахунків цеху",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.left,
          ),
          ShopResultCard(
            title: "Коефіцієнт використання цеху (Крупні ЕП)",
            result: "$fullUsageCoefficientLarge",
          ),
          ShopResultCard(
            title: "Ефективна кількість ЕП цеху",
            result: "$effectiveLoadPowerFull",
          ),
          ShopResultCard(
            title: "Активне навантаження на шинах 0,38 кВ ТП",
            result: "$overallActivePower",
          ),
          ShopResultCard(
            title: "Реактивне навантаження на шинах 0,38 кВ ТП",
            result: "$overallReactivePower",
          ),
          ShopResultCard(
            title: "Повна потужність на шинах 0,38 кВ ТП",
            result: "$overallShopPower",
          ),
          ShopResultCard(
            title: "Груповий струм на шинах 0,38 кВ ТП",
            result: "$overallGroupCurrent",
          ),
        ],
      ),
    );
  }
}
