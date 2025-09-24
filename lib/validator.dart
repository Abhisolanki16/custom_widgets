class Validator {
  /// Validate Name: Should not be empty and only alphabets + spaces allowed
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    final nameRegExp = RegExp(r"^[a-zA-Z\s]+$");
    if (!nameRegExp.hasMatch(value.trim())) {
      return 'Name can only contain alphabets and spaces';
    }
    return null;
  }

  /// Validate Email: Basic email format validation
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegExp.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// Validate Password: Min 8 chars, at least 1 upper, 1 lower, 1 number, 1 special char
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    final passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters, include upper, lower, number & special char';
    }
    return null;
  }

  /// Validate Phone Number: 10 digits (India style)
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegExp = RegExp(r'^[6-9]\d{9}$');
    if (!phoneRegExp.hasMatch(value.trim())) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  /// Validate non-empty field
  static String? validateRequired(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate Age: Must be numeric and within a range
  static String? validateAge(String? value, {int min = 0, int max = 120}) {
    if (value == null || value.trim().isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value.trim());
    if (age == null) return 'Enter a valid age';
    if (age < min || age > max) return 'Age must be between $min and $max';
    return null;
  }

  /// Validate URL
  static String? validateURL(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required';
    }
    final urlRegExp = RegExp(
      r'^(https?:\/\/)?([\w\d-]+\.){1,}([a-zA-Z]{2,6})(\/[\w\d-./?%&=]*)?$',
    );
    if (!urlRegExp.hasMatch(value.trim())) {
      return 'Enter a valid URL';
    }
    return null;
  }
}
