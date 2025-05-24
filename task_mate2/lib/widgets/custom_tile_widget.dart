import 'package:flutter/material.dart';
import 'package:task_mate2/util/consts.dart';
import 'package:task_mate2/widgets/customtext.dart';

class CustomTileWidget extends StatelessWidget {
  String title;
  String isCompleted;
  String dueDate;
  VoidCallback onTap;
  CustomTileWidget({super.key ,required this.title,required this.dueDate,required this.isCompleted,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return 
    InkWell(
      onTap: onTap,
      child: Container(
        padding:const EdgeInsets.all(16),
            margin:const EdgeInsets.all(16),
       // height: 80,
        decoration: BoxDecoration(
          color:containercolor,
          borderRadius: BorderRadius.circular(20)
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 30,right: 30 ,),
          child: Column(
            
       //     mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Customtext(text: title,color: Colors.white,),
              Row(
                children: [
              const   Expanded(
                child:  Divider(
                  color: Colors.white,
                ),
              ),
                  Checkbox(
                    
                    value: false, onChanged:(value) {
                    
                  },),
                ],
                
              ),
            Row(
                children: [
                const  Icon(Icons.access_time,color: Colors.white,),
                  Customtext(text: dueDate,color: Colors.white,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  //  Container(
  //     margin: EdgeInsets.all(16),
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Color(0xFFFDE6FF), // Light pink-purple background
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Expanded(
  //               child: Text(
  //                 'Meeting with Team',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.all(6),
  //               decoration: BoxDecoration(
  //                 color: Colors.black87,
  //                 borderRadius: BorderRadius.circular(6),
  //               ),
  //               child: Icon(
  //                 Icons.check,
  //                 color: Colors.white,
  //                 size: 16,
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 8),
  //         Divider(color: Colors.black26),
  //         SizedBox(height: 8),
  //         Row(
  //           children: [
  //             Icon(Icons.access_time, size: 18, color: Colors.black),
  //             SizedBox(width: 8),
  //             Text(
  //               '10 am',
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 color: Colors.black87,
  //               ),
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //   );
   }
}