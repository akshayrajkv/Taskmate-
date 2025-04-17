import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logoutservice {

Future<  void> logout(BuildContext context)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_Token');
    Navigator.pushNamed(context, '/loginscreen');
  }
}