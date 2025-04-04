import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab6/widgets/electrical_appliances_tab.dart';
import 'package:flutter_labs/labs/lab6/widgets/large_electric_appliances.dart';
import 'package:flutter_labs/labs/lab6/widgets/shop_group_calculations.dart';

class ElectricalLoadCalculationsScreen extends StatefulWidget {
  const ElectricalLoadCalculationsScreen({super.key});

  @override
  _ElectricalLoadCalculationsScreenState createState() =>
      _ElectricalLoadCalculationsScreenState();
}

class _ElectricalLoadCalculationsScreenState
    extends State<ElectricalLoadCalculationsScreen> {
  int _selectedTabIndex = 0;

  final List<String> _tabs = [
    "Прилади",
    "Великі прилади",
    "Загальні показники цеху"
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Column(
        children: [
          TabBar(
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            tabs: _tabs
                .map(
                  (tab) => Tab(
                    text: tab,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              children: [
                ElectricAppliancesTab(),
                LargeElectricAppliancesTab(),
                const ShopGroupCalculationsComponent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
