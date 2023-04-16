class Validator {
  static String? validateEmail(String? input) {
    String? message;
    if (input!.isEmpty) {
      message = "Email address is required";
    } else if (!input.contains('@')) {
      message = "Invalid email address";
    }
    return message;
  }

  static String? validatePassword(String? input) {
    Pattern pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
    RegExp regExp = RegExp(pattern.toString());
    String? message;
    if (input!.isEmpty) {
      message = "Password is required";
    } else if (input.length != 8 && !regExp.hasMatch(input)) {
      message =
          "Password must contain at least one upper case, lower case, number and special character";
    }
    return message;
  }

  static String? validateEmpty(String? input) {
    String? message;
    if (input!.isEmpty) {
      message = "This field is required";
    }
    return message;
  }
}
