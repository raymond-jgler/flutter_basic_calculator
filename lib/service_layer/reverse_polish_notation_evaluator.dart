import 'local_stack.dart';

class RPNEvaluator {
  static final RPNEvaluator _evaluator = RPNEvaluator._internal();

  factory RPNEvaluator() {
    return _evaluator;
  }

  RPNEvaluator._internal();

  late final LocalStack<String> stack;

  void setExpression(LocalStack<String> stack) {
    this.stack = stack;
  }

  double autoResolve() {
    double res = 0.0;
    while (!stack.isEmpty()) {
      String operator = tryPop;
      double operand2 = double.parse(tryPop);
      double operand1 = double.parse(tryPop);
      res += resolve(operand1, operand2, operator);
      stack.push(res.toString());
    }

    return res;
  }

  String get tryPop {
    if (stack.isEmpty()) {
      throw Exception("Stack is emtpy, can't perform calculation");
    }
    return stack.pop();
  }

  double resolve(double a, double b, String operator) {
    double res = 0.0;
    switch (operator) {
      case '+':
        res = a + b;
        break;
      case '-':
        res = a - b;
        break;
      case '*':
        res = a * b;
        break;
      case '/':
        res = a / b;
        break;
      default:
        throw Exception("Unknown operator");
    }
    return res;
  }
}

void main() {
  final myStack = LocalStack<String>();

  myStack.push('Green Eggs and Ham');
  myStack.push('War and Peace');
  myStack.push('Moby Dick');

  RPNEvaluator evaluator = RPNEvaluator();
  evaluator.setExpression(myStack);
}
