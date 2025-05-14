import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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
    final response = await http.get(Uri.parse("$baseUrl/profile/"),
    headers: {
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


Future<void>updateuserdetails(String profileimage)async{

final pref = await SharedPreferences.getInstance();
String?token =pref.getString("auth_Token");
if(token==null)return;
final response = await http.patch(Uri.parse("$baseUrl/profile/image/"),
headers: {
  "Authorization":"Bearer $token",
  "Content-type":"application/json",
},
body: jsonEncode(
  {"profileImage":profileimage}
),


);
  if (response.statusCode == 200 || response.statusCode == 204) {
    print("Profile image updated successfully.");
  } else {
    print("Failed to update profile image: ${response.statusCode}");
    print("Response body: ${response.body}");
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
      print('todos feached');

      Map<String, dynamic> data = json.decode(response.body); // Convert to Map
     print("API Response: $data"); // Debugging

      if (data.containsKey("tasks") && data["tasks"] is List) {
        List<dynamic> jsonList = data["tasks"]; // Extract list
     //   print("Extracted tasks: $jsonList"); // Debugging

        List<Todoclass> todos =
            jsonList.map((json) => Todoclass.fromJson(json)).toList();
    //    print("Converted to Todo List: $todos"); // Debugging

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
  
    final response = await http.post(
      Uri.parse("$baseUrl/tasks/"), // API endpoint
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode(todo.toJson()),
    );
    print( "create student response code: ${ response.statusCode}");
  //  print(response.body);
    return response.statusCode == 201; // Return true if successfully created
  }
// updating todo 

Future<bool>updateTodo(String taskid,Todoclass todo)async{
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_Token');

  if(token==null){
    return false;
  }
  try{
  final response = await http.patch(Uri.parse('$baseUrl/tasks/$taskid'),
  headers:{
    "Authorization":"Bearer $token",
    "content-type":"application/json"
  },
  
  body:jsonEncode(todo.toJson()),
    );
//print(response.body);
print("update student response code ${ response.statusCode}");
return response.statusCode==200;}
catch(e){
  print("Error updating task :$e");
  return false;
}
}

// deleto todo 

Future<void>deleteTodo(String taskid)async{
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_Token');

  if(token==null){
    return;
  }
  try{
    final response = await http.delete(Uri.parse("$baseUrl/tasks/$taskid"),
    headers: {
    "Authorization":"Bearer $token",
    "content-type":"application/json"
    }
    
    ).timeout(const Duration(seconds: 10));
    print("Delete respose status : ${response.statusCode}");
   // print(response.body);
  }catch(e){
    print("error for deleting time out or request faild: $e");
  }

}








  // get All category

  Future<List<String>?> getAllcategory() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_Token');

    if (token == null) {
      return null;
    }
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/categories/all"),
        // headers: {
        //   "Authorization": "Bearer $token",
        //   "Content-Type": "application/json"
        // },
      );

      if (response.statusCode == 200) {
        final decodebody = jsonDecode(response.body);
        Categorymodel category = Categorymodel.fromJson(decodebody);
        return category.categories;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<String>?> getUsercategory() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_Token');

    if (token == null) {
      return null;
    }
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/users/categories/"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final decodebody = jsonDecode(response.body);
        Categorymodel category = Categorymodel.fromJson(decodebody);
        return category.categories;
      }
    } catch (e) {
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

    final response = await http
        .get(Uri.parse("$baseUrl/tasks/?category=$category"), headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      print("THE CATEGORY TODOS ARE");
   //   print(response.body);

      Map<String, dynamic> data = json.decode(response.body); // Convert to Map
   //   print("API Response: $data"); // Debugging

      if (data.containsKey("tasks") && data["tasks"] is List) {
        List<dynamic> jsonList = data["tasks"]; // Extract list
 //       print("Extracted tasks: $jsonList"); // Debugging

        List<Todoclass> todos =
            jsonList.map((json) => Todoclass.fromJson(json)).toList();
   //     print("Converted to Todo List: $todos"); // Debugging

        return todos;
      } else {
        return null; // No tasks found
      }
    }
    return null;
  }

  //adding new category
  Future<void> addnewcategory(String newcategory) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_Token");

    if (token == null) {
      print("the token is null");
      return;
    }
    final response = await http.post(
      Uri.parse("$baseUrl/users/categories/"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"name": newcategory}),
    );
    if (response.statusCode == 201) {
      print("sussess");
    } else {
      print("the category add response code : ${response.statusCode}");
    }
    ;
  }
}
