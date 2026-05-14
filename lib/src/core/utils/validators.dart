final _emailRegex = RegExp(r'^[\w.+\-]+@[a-zA-Z\d\-]+(\.[a-zA-Z\d\-]+)*\.[a-zA-Z]{2,}$');

final _passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~_\-]).{8,}$');

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Email is required';
  if (!_emailRegex.hasMatch(value)) return 'Enter a valid email address';
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';
  if (value.length < 8) return 'Password must be at least 8 characters';
  if (!_passwordRegex.hasMatch(value)) {
    return 'Password must include uppercase, lowercase, number, and special character';
  }
  return null;
}
