typedef Validator = String? Function(String? value);

String? validate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Data is required';
  }
  return null;
}

String? validateUsername(String? value) {
  const String pattern = r'^(?![0-9])[\dA-Za-z]+$';
  final RegExp regex = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return 'Username is required';
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid username';
  }
  return null;
}

String? validateEmail(String? value) {
  const String pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final RegExp regex = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return 'Email is required';
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  // const String pattern =
  //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  const String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  final RegExp regex = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return 'Password is required';
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid password';
  }
  return null;
}
