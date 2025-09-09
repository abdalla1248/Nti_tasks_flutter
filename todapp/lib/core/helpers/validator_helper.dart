class ValidatorHelper {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final regex = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+");
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  static String? validateConfirmPassword(String? conpass,String?newpas) {
    if (conpass == null || conpass.isEmpty) {
      return 'ConfirmPassword is required';
    }
    if (conpass!=newpas) {
      return 'Not Match';
    }
    return null;
  }

  static String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'UserName is required';
    }
    return null;
  }
   static String? phoneValidator(String? value)
  {
    var regex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    if(!regex.hasMatch(value??""))
    {
      return 'Please enter valid phone number';
    }
    return null;
  }

  static String? requiredValidator(String? value)
  {
    if(value == null || value.isEmpty)
    {
      return 'Please enter value';
    }
    return null;
  }
}
