import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _HOST_KEY = "host";
  static const _PORT_KEY = "port";
  static const _USERNAME_KEY = "username";
  static const _PASSWORD_KEY = "password";

  static Future<String?> brokerHost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_HOST_KEY);
  }
  static void setHost(String host) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_HOST_KEY, host);
  }

  static Future<int> brokerPort() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_PORT_KEY) ?? 1883;
  }

  static Future<String?> username() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_USERNAME_KEY);
  }
  static void setUsername(String uname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_USERNAME_KEY, uname);
  }

  static Future<String?> password() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PASSWORD_KEY);
  }
  static void setPassword(String pw) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PASSWORD_KEY, pw);
  }
}
