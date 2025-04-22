import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mate2/features/todo_screen/model/categorymodel%20.dart';

import 'package:task_mate2/features/todo_screen/model/todomodel.dart';
import 'package:task_mate2/features/todo_screen/model/userdetailmodel.dart';

class TodoServises {
  final String baseUrl = "https://simple-tasks-api.onrender.com";

  // featching user details



  Future<Usermodel?> userdetail() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_Token");

    if (token == null) {
      return null;
    }
    final response = await http.get(Uri.parse("$baseUrl/profile/"), headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> data = json.decode(response.body);
      Usermodel user = Usermodel.fromJson(data);
      return user;
    }
  }
  // fetch data from api

  Future<List<Todoclass>?> fetchTodos() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_Token");

    if (token == null) {
      return null;
    }

    final response = await http.get(Uri.parse("$baseUrl/tasks/"), headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      print(response.body);

      Map<String, dynamic> data = json.decode(response.body); // Convert to Map
      print("API Response: $data"); // Debugging

      if (data.containsKey("tasks") && data["tasks"] is List) {
        List<dynamic> jsonList = data["tasks"]; // Extract list
        print("Extracted tasks: $jsonList"); // Debugging

        List<Todoclass> todos =
            jsonList.map((json) => Todoclass.fromJson(json)).toList();
        print("Converted to Todo List: $todos"); // Debugging

        return todos;
      } else {
        return null; // No tasks found
      }
    }
    return null;
  }

//create todo

  Future<bool> createTodo(Todoclass todo) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_Token');

    if (token == null) return false;
    print("Sending to API: ${jsonEncode(todo.toJson())}");
    final response = await http.post(Uri.parse("$baseUrl/tasks/"), // API endpoint
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode(todo.toJson()),
    );
    print(response.statusCode);
    print(response.body);
    return response.statusCode == 201; // Return true if successfully created
  }
  // get user category

  Future<List<String>?> getAllcategory() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_Token');

    if (token == null) {
      return null;
    }
    try{
    final response = await http.get(Uri.parse("$baseUrl/categories/all/"));
    if (response.statusCode == 200) {
      final decodebode = jsonDecode(response.body);
      Categorymodel category = Categorymodel.fromJson(decodebode);
      return category.categories;
    }
    }
    catch(e){
      print(e);
    }
  }


// feaching data using category

 Future<List<Todoclass>?> fetchcategorytodos(String category) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_Token");

    if (token == null) {
      return null;
    }

    final response = await http.get(Uri.parse("$baseUrl/tasks/?category=$category"), headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      print(response.body);

      Map<String, dynamic> data = json.decode(response.body); // Convert to Map
      print("API Response: $data"); // Debugging

      if (data.containsKey("tasks") && data["tasks"] is List) {
        List<dynamic> jsonList = data["tasks"]; // Extract list
        print("Extracted tasks: $jsonList"); // Debugging

        List<Todoclass> todos =
            jsonList.map((json) => Todoclass.fromJson(json)).toList();
        print("Converted to Todo List: $todos"); // Debugging

        return todos;
      } else {
        return null; // No tasks found
      }
    }
    return null;
  }



}








