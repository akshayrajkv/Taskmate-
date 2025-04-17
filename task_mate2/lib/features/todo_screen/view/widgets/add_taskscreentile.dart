import 'package:flutter/material.dart';

class AddTaskscreentile extends StatelessWidget {
  FocusNode? focusNode;
  IconData leadingicon;
  String title;
  Widget trailing;
Function  ontap;
  AddTaskscreentile({super.key,
    this.focusNode,
  required this.leadingicon,required this.title,required this.trailing,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      focusNode: focusNode
      ,
      onTap: (){
        ontap;
      },
      child: Container(
        height: 50,
        child: ListTile(
          leading:Icon(leadingicon,color: Colors.white,),
          title: Text(title,
          style:const TextStyle(color: Colors.white),),
          trailing: trailing,
        ),
      ),
    );
  }
}