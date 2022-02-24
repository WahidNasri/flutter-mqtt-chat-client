class AppValidators {
  static String? isValidHost(String? host) {
    if (host == null) {
      return 'Please enter a valid host address';
    }
    bool validUrl = RegExp(
            r"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$")
        .hasMatch(host);
    if (!validUrl) {
      return 'Please enter a valid host address';
    }
  }

  static String? isValidEmail(String? email) {
    if (email == null) {
      return 'Please enter a valid email address';
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      return 'Please enter a valid email address';
    }
  }

  static String? isValidPassword(String? pass) {
    if (pass == null) {
      return ' Please enter a password';
    }
    if (pass.isEmpty) {
      return ' Please enter a password';
    }
  }
}
