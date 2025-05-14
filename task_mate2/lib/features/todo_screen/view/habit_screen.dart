import 'package:flutter/material.dart';
import 'package:task_mate2/widgets/custom_tile_widget.dart';
import 'package:task_mate2/widgets/customtext.dart';

class HabitScreen extends StatelessWidget {
  const HabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Customtext(text: 'Habit',color:Colors.black,),

      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
          
          return CustomTileWidget(title: 'ff', dueDate: '', isCompleted: 'falsr', onTap:(){});
        },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},
      child:const Icon(Icons.add),
      ),

    );
  }
}