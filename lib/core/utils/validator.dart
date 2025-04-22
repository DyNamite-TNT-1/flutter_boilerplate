class Validator {
  static bool isValidEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  static bool isValidPassword(String value) {
    return value.length >= 6;
  }
}
