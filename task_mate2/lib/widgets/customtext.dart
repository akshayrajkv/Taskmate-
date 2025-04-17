import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customtext extends StatelessWidget {
  final String text;
 final double? size ;
 final Color? color;
  const Customtext({super.key ,
   required this.text,
   this.color=Colors.white
   ,this.size=22});

  @override
  Widget build(BuildContext context) {
    return  Text(text, style:GoogleFonts.notoSans(color:color,fontSize: size,
    fontWeight: FontWeight.bold),);
  }
}