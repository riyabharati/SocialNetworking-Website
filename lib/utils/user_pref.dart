import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future? setToken(String? name) async =>
      await _preferences!.setString(KeyName.token, name!);
  static String? getToken() => _preferences!.getString(KeyName.token);

  static logoutUser() {
    _preferences!.remove(KeyName.token);
  }
}

class KeyName {
  static String token = "token";
}
