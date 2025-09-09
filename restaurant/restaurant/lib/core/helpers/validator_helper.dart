class ValidatorHelper {
  /// Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final regex = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$");
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// Validate Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Confirm Password Validation
  static String? validateConfirmPassword(String? confirm, String? newPass) {
    if (confirm == null || confirm.isEmpty) {
      return 'Confirm password is required';
    }
    if (confirm != newPass) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Validate Non-Empty Text (like username)
  static String? validateNotEmpty(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate Phone Number
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final regex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Generic Required Validator
  static String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter value';
    }
    return null;
  }
}
