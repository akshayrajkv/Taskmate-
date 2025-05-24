import 'package:flutter/material.dart';
import 'package:task_mate2/features/habit/view/pages/add_habit.dart';
import 'package:task_mate2/util/consts.dart';
import 'package:task_mate2/widgets/custom_tile_widget.dart';
import 'package:task_mate2/widgets/customtext.dart';

class HabitScreen extends StatelessWidget {
  const HabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    
      body: Container(
        decoration:const BoxDecoration(
                image: DecorationImage(image:backgroundimage ,fit: BoxFit.cover),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start 
          ,
          children: [
            const     SizedBox(height: 80,),
                const    Padding(
                      padding:  EdgeInsets.only(left: 30),
                      child: Customtext(text: 'Habit',color:Colors.white,),
                    ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                
                return CustomTileWidget(title: 'ff', dueDate: '', isCompleted: 'falsr', onTap:(){});
              },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const AddHabit();
        },));
      },
      child:const Icon(Icons.add),
      ),

    );
  }
}