class VoidValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validateIdCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Id Card Number is required';
    }
    final cardRegEx = RegExp(r'^\d+$');
    if (!cardRegEx.hasMatch(value)) {
      return 'Card Number Should Only Contain Numbers.';
    }
    return null;
  }

  static String? validateValidThrough(String? value) {
    if (value == null || value.isEmpty) {
      return 'Valid Through is required';
    }

    final validThroughRegEx = RegExp(r'^(0[1-9]|1[0-2])/[0-9]{2}$');
    if (!validThroughRegEx.hasMatch(value)) {
      return 'Valid Through must be in MM/YY format, where MM is 01-12';
    }

    return null;
  }

  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    //final emailRegExp = RegExp(r'^\d{10}$');
    final RegExp phoneRegEx = RegExp(r'^\+(?:[0-9]●?){6,14}[0-9]$');
    if (!value.startsWith('+')) {
      return 'Phone number must start with a plus sign (+).';
    }
    if (value.length > 16) {
      return "The Phone Number is too long";
    }
    if (value.length < 8) {
      return "The Phone Number is short it should contain minimum of 7 digits";
    }

    if (!phoneRegEx.hasMatch(value)) {
      return 'Invalid phone number.';
    }
    return null;
  }

  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.trim().isEmpty) {
      //VoidLoaders.warningSnackBar(title: fieldName, message: value??"Null");
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card Number is required';
    }

    final cardRegEx = RegExp(r'^\d{13,19}$');
    if (!cardRegEx.hasMatch(value)) {
      return 'Card Number should be between 13 and 19 digits.';
    }

    // if (!luhnCheck(value)) {
    //   return 'Invalid Card Number.';
    // }

    return null;
  }

  static bool luhnCheck(String cardNumber) {
    int sum = 0;
    bool alternate = false;
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int n = int.parse(cardNumber[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) {
          n -= 9;
        }
      }
      sum += n;
      alternate = !alternate;
    }
    return (sum % 10 == 0);
  }
}
