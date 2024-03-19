import 'local_stack.dart';

class RPNEvaluator {
  static final RPNEvaluator _evaluator = RPNEvaluator._internal();

  RPNEvaluator._internal();

  factory RPNEvaluator() {
    return _evaluator;
  }

  late LocalStack<String> stack;

  void withExpr(LocalStack<String> stack) {
    this.stack = stack;
  }

  double autoResolve([LocalStack<String>? operationContainer]) {
    withExpr(operationContainer!);
    return resolveIt();
  }

  double resolveIt() {
    double res = 0.0;
    while (!stack.isEmpty()) {
      String operator = tryPop();
      double operand2 = double.parse(tryPop());
      double operand1 = double.parse(tryPop());
      res += resolve(operand1, operand2, operator);
      if (stack.isEmpty()) {
        break;
      }
      stack.push(res.toString());
    }
    return res;
  }

  String tryPop() {
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
      case 'X':
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
  evaluator.withExpr(myStack);
}
