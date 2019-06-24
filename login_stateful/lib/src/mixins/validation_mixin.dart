class ValidationMixin {
  String validatePassword(String value) {
    if (value.length < 4) {
      return 'Password needs at least 4 characters';
    }

    return null;
  }

  String validateEmail(String value) {
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }

    return null;
  }
}
