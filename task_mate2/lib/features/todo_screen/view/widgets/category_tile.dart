import 'package:flutter/material.dart';
import 'package:task_mate2/widgets/customtext.dart';

class Catagorytile extends StatelessWidget {
 VoidCallback? onTap;
  String catogoryitem;
  final Color color;
 final IconData icon;
  final Color bodercolor;
Color? iconcolor;
  
  Catagorytile(
      {super.key,
      
      this.onTap,
  this.catogoryitem = 'Habit',
      this.color = const Color.fromARGB(255, 107, 215, 113),
        this.icon=Icons.add_ic_call_outlined,
   required this.bodercolor,
 this.iconcolor
 });
  @override
  
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 125,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.5,
              color:bodercolor
            )
          ),
          child:  Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Icon(icon,
               color: iconcolor,
                  ),
                const     SizedBox( height: 30,),
                Customtext(text :catogoryitem ,),
              const   SizedBox(height: 20,),
            const   Row(
                  children: [
                  SizedBox(width: 70,),
                  
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
