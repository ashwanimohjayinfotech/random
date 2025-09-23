import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = "http://localhost:3000/api/users";
  // For real devices, replace "localhost" with your computer's IP address

  // GET all users
  static Future<List> getUsers() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);

      // Case 1: backend sends { "users": [...] }
      if (data is Map && data.containsKey("users")) {
        return data["users"];
      }

      // Case 2: backend sends just an array
      if (data is List) {
        return data;
      }

      return [];
    } else {
      throw Exception("Failed to load users: ${res.body}");
    }
  }

  // CREATE user
  static Future<void> createUser(String name, String email) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"name": name, "email": email}),
    );
    if (res.statusCode != 201) {
      throw Exception("Failed to create user: ${res.body}");
    }
  }

  // UPDATE user
  static Future<void> updateUser(String id, String name, String email) async {
    final res = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"name": name, "email": email}),
    );
    if (res.statusCode != 200) {
      throw Exception("Failed to update user: ${res.body}");
    }
  }

  // DELETE user
  static Future<void> deleteUser(String id) async {
    final res = await http.delete(Uri.parse("$baseUrl/$id"));
    if (res.statusCode != 200) {
      throw Exception("Failed to delete user: ${res.body}");
    }
  }
}
