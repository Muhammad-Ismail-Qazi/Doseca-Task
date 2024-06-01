String? validateEmail(String value) {
  if (value.isEmpty ||
      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
    return 'Enter a valid email!';
  }
  return null;
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Please enter a password';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters';
  } else if (!RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*()_+{}|<>?])')
      .hasMatch(value)) {
    return 'Password should contain at least one uppercase letter, one lowercase letter, one digit, and one special character';
  }
  return null; // Return null when the password is valid.
}