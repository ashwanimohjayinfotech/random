import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "http://localhost:3000/api/v1"; 
  

  /// SIGNUP
  static Future<bool> signup(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "role": 0,
      }),
    );

    if (response.statusCode == 201) {
      return true; // success
    } else {
      return false;
    }
  }

  /// LOGIN
   static Future<Map<String, dynamic>> login(String email, String password) async {
  final response = await http.post(
    Uri.parse("$baseUrl/login"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": email,
      "password": password,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return {
      "success": true,
      "role": data["user"]["role"], 
      "token": data["token"],      
    };
  } else {
    return {"success": false};
  }
}
}