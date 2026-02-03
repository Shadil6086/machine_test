import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> body) async {
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Something went wrong");
    }
  }
}
