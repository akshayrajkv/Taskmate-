import 'package:flutter/material.dart';
import 'package:task_mate2/features/pofile&settings/services/logoutservice.dart';
import 'package:task_mate2/features/todo_screen/services/todo_servises.dart';

class Profilepage extends StatelessWidget {
 Profilepage({super.key});
Logoutservice _logoutservice =Logoutservice();
TodoServises _todoServises = TodoServises();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(child: IconButton(
            onPressed:()=> _logoutservice.logout(context),
          icon:const Icon(Icons.logout))),
          IconButton(onPressed: (){
                _todoServises.getAllcategory();
          }, icon:Icon(Icons.add))
        ],
      ),
    );
  }
}