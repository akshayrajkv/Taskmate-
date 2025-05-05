import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mate2/features/auth/view/login_screen.dart';
import 'package:task_mate2/features/todo_screen/view/home.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    
    super.initState();
  _navigateToNextScreen();
  }
void _navigateToNextScreen()async{
await Future.delayed(Duration(seconds: 3));

  final prefs = await SharedPreferences.getInstance();
  String? _token = prefs.getString("auth_Token");
print('splash toke:$_token');

if(_token==null){

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginScreen(),));

}
else{
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
}
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body:Center(
        child: Image.asset('assets/Taskmate.dark.png'),
      ),
    );
  }
}