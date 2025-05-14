import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_mate2/features/todo_screen/view/edit_todo.dart';
import 'package:task_mate2/features/todo_screen/view/widgets/task_tile.dart';
import 'package:task_mate2/features/todo_screen/view_model/todo_viewmodel.dart';
import 'package:task_mate2/widgets/customtext.dart';

class Taskcontainer extends StatefulWidget {
 

  Taskcontainer({
    super.key,
  
  });

  @override
  State<Taskcontainer> createState() => _TaskcontainerState();
}

class _TaskcontainerState extends State<Taskcontainer> {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
 
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      //  Initial filtering on today's date
    
    final provider=  Provider.of<TodoViewModel>(context, listen: false);
   await provider.fetchTodos();
   provider.filtertaskbyduedate(formattedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Column(
    //    mainAxisAlignment: MainAxisAlignment.sta,
    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
    Padding(
      padding: const EdgeInsets.only(left: 22,right: 22,bottom: 20,top: 20),
      child:     Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
            const     Customtext(
                  text: "Today's Tasks",
                  color: Colors.black,
                ),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context,'/alltodopage');
                }, child:const Text('See All',
                ))
              ],
            ),
            ),
          
          Expanded(child:
              Consumer<TodoViewModel>(
            builder: (context, todoprovider, _) {
              if (todoprovider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final todos = todoprovider.filtertasks;
        return   todos.isEmpty
                    ? Center(child: Text("No tasks for Today")):

              ListView.builder(
                padding: EdgeInsets.zero,
              
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Column(
                  
                    children: [
                      Tasktile(
                        onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) {
                        return  EditTodo(todo: todos[index]);
                        },));
                        },
                        isChecked: false,
                        title: todo.title.toString(),
                      ),
                    ],
                  );
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
