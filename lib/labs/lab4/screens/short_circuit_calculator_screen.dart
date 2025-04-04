import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab4/widgets/HPnEM_short_circuit_tab.dart';
import 'package:flutter_labs/labs/lab4/widgets/cable_selection_tab.dart';
import 'package:flutter_labs/labs/lab4/widgets/short_circuit_tab.dart';

class ShortCircuitCalculatorScreen extends StatefulWidget {
  const ShortCircuitCalculatorScreen({super.key});

  @override
  _ShortCircuitCalculatorScreenState createState() =>
      _ShortCircuitCalculatorScreenState();
}

class _ShortCircuitCalculatorScreenState extends State<ShortCircuitCalculatorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "КЗ"),
            Tab(text: "ХПнЕМ"),
            Tab(text: "Кабель"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              ShortCircuitTab(),
              HPnEMShortCircuitTab(),
              CableSelectionTab(),
            ],
          ),
        ),
      ],
    );
  }
}
