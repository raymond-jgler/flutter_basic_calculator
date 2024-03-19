class InputUtil {
  static bool isOperand(String str) {
    if (str == null) {
      return false;
    }
    final number = double.tryParse(str);
    return number != null;
  }

  static bool isNumber(String str) {
    return isOperand(str);
  }

  static bool isOperator(String str) {
    return !isOperand(str);
  }

  static bool containsAtLeastOneOperator(String str) {
    return str.contains('+') || str.contains('x') || str.contains('/');
  }
}
