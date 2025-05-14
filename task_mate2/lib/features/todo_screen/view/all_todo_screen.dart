// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:task_mate2/features/todo_screen/view_model/todo_viewmodel.dart';
// import 'package:task_mate2/widgets/custom_tile_widget.dart';
// import 'package:task_mate2/widgets/customtext.dart';
// import 'package:task_mate2/widgets/tododateselector.dart';

// class AllTodoScreen extends StatefulWidget {
//   const AllTodoScreen({super.key});

//   @override
//   State<AllTodoScreen> createState() => _AllTodoScreenState();
// }


// String formattedDate = DateFormat('MMMM d').format(DateTime.now());

// class _AllTodoScreenState extends State<AllTodoScreen> {
//   @override
  
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Customtext(
//           text: formattedDate,
//           color: Colors.black,
//         ),
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [DateScroller(onDateSelected: (p0) => DateTime.now()),
//           Expanded(
//             child: Consumer<TodoViewModel>(
//               builder: (context, value, child) {
                
//                 final filtertodos = value.filtertasks;
              
//               return ListView.builder(
//                 itemCount:filtertodos.length,
//                 itemBuilder: (context, index) {
//                 return CustomTileWidget(title: 'dddd', dueDate: '', isCompleted: '');
//               },
//               );
//    } ),
//           )
          
//           ],

//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_mate2/features/todo_screen/view/edit_todo.dart';
import 'package:task_mate2/features/todo_screen/view_model/todo_viewmodel.dart';
import 'package:task_mate2/widgets/custom_tile_widget.dart';
import 'package:task_mate2/widgets/customtext.dart';
import 'package:task_mate2/widgets/tododateselector.dart';

class AllTodoScreen extends StatefulWidget {
  const AllTodoScreen({super.key});

  @override
  State<AllTodoScreen> createState() => _AllTodoScreenState();
}

class _AllTodoScreenState extends State<AllTodoScreen> {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now()); //  For backend filtering

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //  Initial filtering on today's date
      Provider.of<TodoViewModel>(context, listen: false)
          .filtertaskbyduedate(formattedDate);
    });
  }

  //  Called when a new date is picked in DateScroller
  void _onDateSelected(DateTime selectedDate) {
    String newDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    setState(() {
      formattedDate = newDate;
    });

    Provider.of<TodoViewModel>(context, listen: false)
        .filtertaskbyduedate(newDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  Show user-friendly date
        title: Customtext(
          text: DateFormat('MMMM d').format(DateTime.parse(formattedDate)),
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Pass working callback
          DateScroller(onDateSelected: _onDateSelected),

          //  Listen to ViewModel and build filtered task list
          Expanded(
            child: Consumer<TodoViewModel>(
              builder: (context, value, child) {
                final filtertodos = value.filtertasks;

                return filtertodos.isEmpty
                    ? Center(child: Text("No tasks for this date"))
                    : ListView.builder(
                        itemCount: filtertodos.length,
                        itemBuilder: (context, index) {
                          final task = filtertodos[index];
                          return CustomTileWidget(
                            onTap: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) {
                                return EditTodo(todo: task);
                              },));
                            },
                            title: task.title.toString(),
                            dueDate: task.dueDate!.split("T")[0],
                            isCompleted: task.isCompleted.toString() ,
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
