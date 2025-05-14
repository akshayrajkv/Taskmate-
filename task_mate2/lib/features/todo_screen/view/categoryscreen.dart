import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate2/features/todo_screen/view/edit_todo.dart';
import 'package:task_mate2/features/todo_screen/view_model/todo_viewmodel.dart';
import 'package:task_mate2/util/consts.dart';
import 'package:task_mate2/widgets/custom_tile_widget.dart';
import 'package:task_mate2/widgets/customtext.dart';
import 'package:task_mate2/widgets/tododateselector.dart';

class CategoryPage extends StatefulWidget {
  String categoryy;
  CategoryPage({required this.categoryy, super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewmodel = Provider.of<TodoViewModel>(context, listen: false);
      viewmodel.fetchCatgoryTodos(widget.categoryy);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color(0xFFEA82FF),
            child: Padding(
              padding: const EdgeInsets.only(top: 70, left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
          
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const SizedBox(
                    width: 100,
                  ),
                  Customtext(text: widget.categoryy)
                ],
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
              ),
              child: Column(
                children: [
                  AppSpacing.h10,
                  DateScroller(onDateSelected: (p0) => DateTime.now()),
                  Expanded(
                    child: Consumer<TodoViewModel>(
                        builder: (context, todoprovidr, _) {
                      if (todoprovidr.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final todos = todoprovidr.categorytodos;
                      if (todos == null || todos.isEmpty) {
                        return const Center(
                          child: Text('No todos found'),
                        );
                      }

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final todo = todos[index];
                          return Column(
                            children: [
                              CustomTileWidget(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                                    return EditTodo(todo: todo);
                                  },));
                                },
                                dueDate: todo.title.toString(),
                                isCompleted: todo.isCompleted.toString(),
                                title: todo.title.toString(),
                              ),
                            ],
                          );
                        },
                        itemCount: todos.length,
                      );
                    }),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
