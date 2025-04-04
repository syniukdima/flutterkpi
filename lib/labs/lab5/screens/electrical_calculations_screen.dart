import 'package:flutter/material.dart';
import 'package:flutter_labs/labs/lab5/widgets/loss_tab.dart';
import 'package:flutter_labs/labs/lab5/widgets/reliability_tab.dart';

class ElectricalCalculationsScreen extends StatelessWidget {
  const ElectricalCalculationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "Надійність"),
              Tab(text: "Збитки"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ReliabilityTab(),
                LossTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
