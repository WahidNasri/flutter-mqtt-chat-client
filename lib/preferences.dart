import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final _HOST_KEY = "host";
  static final _PORT_KEY = "port";

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
}
