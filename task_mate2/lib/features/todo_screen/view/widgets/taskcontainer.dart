import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate2/features/todo_screen/view/widgets/task_tile.dart';
import 'package:task_mate2/features/todo_screen/view_model/todo_viewmodel.dart';
import 'package:task_mate2/util/consts.dart';
import 'package:task_mate2/widgets/customtext.dart';

class Taskcontainer extends StatefulWidget {
  ScrollController scrollController;

  Taskcontainer({
    super.key,
    required this.scrollController,
  });

  @override
  State<Taskcontainer> createState() => _TaskcontainerState();
}

class _TaskcontainerState extends State<Taskcontainer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoViewModel>(context, listen: false).fetchTodos();
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Customtext(
            text: "Today's Tasks",
            color: Colors.black,
          ),
          AppSpacing.h20,
          Expanded(child:
              // FutureBuilder<List<Todoclass>?>(
              //   future: todoprovider.fetchTodos(),  // Use the stored future
              //   builder: (context,snapshot) {

              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       print("Has data: ${snapshot.hasData}");
              //       return const Center(child: CircularProgressIndicator());
              //     } else if (snapshot.hasError) {
              //       return Center(
              //         child: Text('Error: ${snapshot.error}'),
              //       );
              //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //       return const Center(
              //         child: Text('No todos found'),
              //       );
              //     } else {
              //       List<Todoclass> todos = snapshot.data!;
              //       return ListView.builder(
              //         controller:widget.scrollController ,
              //         itemCount: todos.length,
              //         itemBuilder: (context, index) {
              //           Todoclass todo = todos[index];
              //           return Column(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //               Tasktile(
              //                 isChecked: false,
              //                 title: todo.title.toString(),
              //               ),
              //               const Divider(thickness: 1),
              //             ],
              //           );
              //         },
              //       );
              //     }
              //   },
              // ),
              Consumer<TodoViewModel>(
            builder: (context, todoprovider, _) {
              if (todoprovider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final todos = todoprovider.todos;
              if (todos == null || todos.isEmpty) {
                return const Center(child: Text("No todos found"));
              }

              return ListView.builder(
                padding: EdgeInsets.zero,
                controller: widget.scrollController,
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Column(
                  
                    children: [
                      Tasktile(
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
