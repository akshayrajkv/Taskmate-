import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_mate2/widgets/custom_tile_widget.dart';
import 'package:task_mate2/widgets/customtext.dart';
import 'package:task_mate2/widgets/tododateselector.dart';

class AllTodoScreen extends StatefulWidget {
  const AllTodoScreen({super.key});

  @override
  State<AllTodoScreen> createState() => _AllTodoScreenState();
}

String formattedDate = DateFormat('MMMM d').format(DateTime.now());

class _AllTodoScreenState extends State<AllTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Customtext(
          text: formattedDate,
          color: Colors.black,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [DateScroller(onDateSelected: (p0) => DateTime.now()),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
              return CustomTileWidget(title: 'dddd', dueDate: '', isCompleted: '');
            },),
          )
          
          ],

        ),
      ),
    );
  }
}
