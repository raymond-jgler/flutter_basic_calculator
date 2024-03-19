import 'package:flutter/material.dart';

import '../stateful_widgets/stateful_calc.dart';

class CalculatorWidgetGateway extends StatelessWidget {
  const CalculatorWidgetGateway({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black, // Title text color
            fontSize: 24, // Title text size
            fontWeight: FontWeight.bold, // Title text weight
            letterSpacing: 1.5, // Title text spacing
          ),
        ),
        backgroundColor: Colors.cyan,
        // Background color
        elevation: 0,
        // No shadow
        centerTitle: true,
        // Center the title
        iconTheme: const IconThemeData(
          color: Colors.black, // Icon color
        ),
      ),
      body: const Center(
        child: StatefulCalculator(),
      ),
    );
  }
}
