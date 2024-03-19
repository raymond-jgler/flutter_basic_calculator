import 'package:flutter/cupertino.dart';

import '../state/calc_state.dart';

class StatefulCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalculatorState();
  }

  const StatefulCalculator({super.key});
}
