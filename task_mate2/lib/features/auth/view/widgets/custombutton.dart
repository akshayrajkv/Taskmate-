import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final Color buttonclr;
  const Custombutton({super.key, required this.name,required this.onPressed,required this.buttonclr});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(onPressed: onPressed, 
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonclr,
      minimumSize:const Size(double.infinity, 50)
    ),
    child:Text(name,style:const TextStyle(color: Color.fromARGB(255, 197, 42, 225),fontSize: 20)),);
  }
}