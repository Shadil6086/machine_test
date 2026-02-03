import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future saveUser(String id, String token) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("id", id);
    pref.setString("token", token);
  }

  static Future<Map<String, String?>> getUser() async {
    final pref = await SharedPreferences.getInstance();
    return {
      "id": pref.getString("id"),
      "token": pref.getString("token"),
    };
  }
}
