import 'package:flutter/material.dart';

abstract class InputValidator {
  /// Method to validate that a string is valid.
  /// Otherwise it returns the text error to be shown to user.
  String? validate(String? input, BuildContext context);
}

class PasswordValidator extends InputValidator {
  /// Method to validate that a string is a valid password.
  /// Otherwise it returns the text error to be shown to user.

  ///   (?=.*[A-Z])        should contain at least one upper case
  ///   (?=.*[a-z])        should contain at least one lower case
  ///   (?=.*?[0-9])       should contain at least one digit
  ///   (?=.*?[!@#\$&*~])  should contain at least one Special character
  ///   .{6,}              Must be at least 6 characters in length

  final RegExp _password =  RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$'
  );
  @override
  String? validate(String? input, BuildContext context) {
    if(!_password.hasMatch(input!)){
        return 'Password must contain minimum 6 characters,\nat least 1 one upper case and lower case,\n1 digit and one special character';
    }
    return null;
  }
}

class ConfirmPasswordValidator extends InputValidator {
  late final TextEditingController passwordController;

  ConfirmPasswordValidator(this.passwordController);

  @override
  String? validate(String? input, BuildContext context) {
    if (input == null || input.isEmpty) {
      return 'Confirm password is required';
    }

    if (input != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }
}


bool isEmail(String input) {
  // Regular expression for validating an email
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  return emailRegExp.hasMatch(input);
}

class EmailValidator extends InputValidator {
  /// Method to validate that a string has email format.
  /// Otherwise it returns the text error to be shown to user.
  @override
  String? validate(String? input, BuildContext context) {
    if (!isEmail(input!.trim())) {
      return 'Please enter a valid email';
    }
    else {
      return null;
    }
  }
}

class EmptyValidator extends InputValidator {
  /// Method to validate that a string is not empty.
  /// Otherwise it returns the text error to be shown to user.
  @override
  String? validate(String? input, BuildContext context) {
    return input!.trim().isEmpty ? 'Empty field' : null;
  }
}


class NoneValidator extends InputValidator {
  /// Method to validate that a string is not empty.
  /// Otherwise it returns the text error to be shown to user.
  @override
  String? validate(String? input, BuildContext context) {
    return  null;
  }
}

