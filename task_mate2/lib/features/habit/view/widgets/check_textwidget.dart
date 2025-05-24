import 'package:flutter/material.dart';
import 'package:task_mate2/util/consts.dart';
import 'package:task_mate2/widgets/customtext.dart';

class CheckTextwidget extends StatelessWidget {
  bool isChecked=false;
  String text;
  
 CheckTextwidget({super.key,required this.isChecked,required this.text});
onchanged(){
  isChecked = true;
}
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Checkbox(
          shape:const CircleBorder(
            side: BorderSide(
                  color:Colors.white,
              width: 2,
            )
          ),
          value:isChecked, onChanged: onchanged(),
  
        ),
      
        AppSpacing.w10,
        Customtext(text: text),
        
      ],
    );
  }
}