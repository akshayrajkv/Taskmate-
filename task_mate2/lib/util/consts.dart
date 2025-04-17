import 'package:flutter/material.dart';

class AppSpacing{
  // hight
  static const SizedBox h10 = SizedBox( height: 10,);
  static const SizedBox h20 = SizedBox(height: 20,);
  static const SizedBox h30 = SizedBox(height: 30,);
  static const SizedBox h40 = SizedBox(height: 40,);
  static const SizedBox h45 = SizedBox(height: 45,);
   //width
  static const SizedBox w10 = SizedBox(width: 10,);
  static const SizedBox w20 = SizedBox(width: 20,);
}




const Gradient backgroundColor =LinearGradient(
                colors: [Color.fromARGB(255, 155, 22, 179), Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight);