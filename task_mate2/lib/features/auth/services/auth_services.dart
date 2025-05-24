import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mate2/features/auth/model/usermodel.dart';



class ApiService {
  final String baseUrl = "https://simple-tasks-api.onrender.com";
  String ?token;

// register user(sing up)

  Future<Map<String, dynamic>> registerUser(User user) async {
  
    final url = Uri.parse("$baseUrl/register/");
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"},
              body: jsonEncode(user.toJson()))
          .timeout(const Duration(seconds: 10));

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        
        final responseBody = jsonDecode(response.body);
        return {"success": true, "message": responseBody["message"]};
        
      } else {
        final responseBody = jsonDecode(response.body);
        return {
          "success": false,
          "message": responseBody["error"] ?? "Registration failed"
        };
      }
    } catch (e) {
      return {"success": false, "message": "Something went wrong: $e"};
    }
  }


//login user 

  Future<Map<String, dynamic>> loginUser(User user) async {
    final url = Uri.parse("$baseUrl/login/");
    try {
      final response = await http.post(
        url,
        // Use form-encoded format
        body: {
          'username': user.email, // or user.username if applicable
          'password': user.password,
        },
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
      print(response.body);
        final data = jsonDecode(response.body);
          
      token = data['access_token'];
      print('your access token is :$token');
      saveToken(token!);
      getToken();
        return {
          "success": true,
          "token": data["access_token"],
          // adjust key name as returned
        };
      } else {
        final responseBody = jsonDecode(response.body);
        return {
          "success": false,
          "message": responseBody["detail"] ?? "Invalid credentials",
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "Something went wrong: $e",
      };
    }
  }
  
  Future<void>saveToken(String token)async{
    final prefs =await SharedPreferences.getInstance();
    await prefs.setString('auth_Token', token);
  }
  Future<String>getToken()async{
      final prefs = await SharedPreferences.getInstance();
      String ?token = prefs.getString('auth_Token');
      print('token:$token');
      return token!;
  }
}
