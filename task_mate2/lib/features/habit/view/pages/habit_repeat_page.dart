import 'package:flutter/material.dart';
import 'package:task_mate2/features/habit/view/widgets/check_textwidget.dart';
import 'package:task_mate2/util/consts.dart';

class HabitRepeatPage extends StatefulWidget {
  const HabitRepeatPage({super.key});

  @override
  State<HabitRepeatPage> createState() => _HabitRepeatPageState();
}

class _HabitRepeatPageState extends State<HabitRepeatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
    //    automaticallyImplyLeading: false,
        title: Text("How often do you want to do it?",style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:const BoxDecoration(
          gradient: backgroundColor
        ),
        child: Column(
          children: [
      const  SizedBox(
              height: 110,
            ),
            CheckTextwidget(
              isChecked:true,
              text: 'Every Day',
              
            ),
                CheckTextwidget(
              isChecked:true,
              text: 'Specific Day of week',
              
            ),
                  CheckTextwidget(
              isChecked:true,
              text: 'Specific Day of The Year',
              
            ),
                CheckTextwidget(
              isChecked:true,
              text: 'Repeat',
              
            ),
      
          ],
      
        ),      ),
    );
  }
}