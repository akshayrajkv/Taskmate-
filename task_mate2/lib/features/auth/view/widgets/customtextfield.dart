import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final IconData? suffixicon;
  final VoidCallback? ontap;
  final bool obscuretext;
  String hinttext;
  
  CustomTextfield({super.key, required this.controller,this.suffixicon,this.ontap,this.obscuretext=false,this.hinttext=""});
      
  @override
  Widget build(BuildContext context) {
    return  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow:[
                      BoxShadow(
                        color: const Color.fromARGB(255, 155, 176, 237),
                        spreadRadius: 1,
                        blurRadius: 1,
                      )
                    ]
                  ),
                  child: TextField(
                    style:const TextStyle(color: Colors.white),
                    obscureText: obscuretext,
                    controller:controller,
                    decoration:  InputDecoration(
                    hintText: hinttext,
                      contentPadding:const EdgeInsets.all(15),
                      border: InputBorder.none,
                      suffixIcon: IconButton(onPressed: ontap,icon: Icon(suffixicon,color: Colors.grey.shade200,),),
                    ),
                    
                  
                  ),
                ) ;
  }
}