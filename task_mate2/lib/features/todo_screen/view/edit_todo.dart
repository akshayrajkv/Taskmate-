import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate2/features/todo_screen/model/todomodel.dart';
import 'package:task_mate2/features/todo_screen/view/widgets/add_taskscreentile.dart';
import 'package:task_mate2/features/todo_screen/view_model/todo_viewmodel.dart';
import 'package:task_mate2/util/consts.dart';
import 'package:task_mate2/widgets/customtext.dart';

class EditTodo extends StatefulWidget {
  Todoclass todo;
  
    EditTodo({super.key,required this.todo});

  @override
  State<EditTodo> createState() => _EditTodo();
  
}

class _EditTodo extends State<EditTodo> {
  // TodoViewModel _todoViewModel =TodoViewModel();
  String? selectedValue = 'Work';
  String? selectedPriority = 'Low';

  List<String> category = ['Work', 'Personal'];
  List<String> priority = ['Low', 'Medium', 'High', 'Urgent'];
 final TextEditingController _taskcontroller =TextEditingController() ;
  final TextEditingController _datetimecontroller = TextEditingController();
  final TextEditingController _timecontroller = TextEditingController();

  late String taskid;
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
  }
@override
void initState() {
  super.initState();
   taskid = widget.todo.taskid!;
  _taskcontroller.text = widget.todo.title.toString();
  _datetimecontroller.text = widget.todo.dueDate ?? '';
  selectedValue = widget.todo.category ?? 'Work';
  selectedPriority = widget.todo.priority ?? 'Low';
}

  @override
  Widget build(BuildContext context) {
  
    final todoprovider = Provider.of<TodoViewModel>(context);
    return Scaffold(
  
      body: Container(
        decoration: const BoxDecoration(
        image:DecorationImage(image:backgroundimage,fit: BoxFit.cover)
        ),
        padding: const EdgeInsets.all(15),
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon:const Icon(Icons.arrow_back,color: Colors.white,)),
              // add task textfiled
              AppSpacing.h10,
              TextField(
                
                textCapitalization: TextCapitalization.sentences,
                focusNode: _focusNode1,
                controller: _taskcontroller,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Task',
                    hintStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(10))),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focusNode2);
                },
              ),

              AppSpacing.h20,
              const Divider(
                color: Colors.white,
              ),
              AddTaskscreentile(
                leadingicon: Icons.category,
                title: 'Category',
                trailing: Container(
                  child: Focus(
                    focusNode: _focusNode2,
                    child: Consumer<TodoViewModel>(
                      builder: (context, value, _) {
                        final category =value.categories;
                          if (selectedValue == null && category!.isNotEmpty) {
          selectedValue = category[0];
                  }
                      
                  return DropdownButton(
                        iconEnabledColor: Colors.white,
                        dropdownColor:const Color(0xFFEA82FF),
                        items: category?.map((String item) {
                          return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style:const TextStyle(color: Colors.white),
                              ));
                        }).toList(),
                        onChanged: (String? newvalue) {
                          setState(
                            () {
                              selectedValue = newvalue;
                            },
                          );
                        },
                        value: selectedValue,
                      );
  }     ),
                    onFocusChange: (_) {
                      FocusScope.of(context).requestFocus(_focusNode3);
                    },
                  ),
                ),
                ontap: () {},
              ),

              const Divider(),

              AppSpacing.h10,
              //date picker
              TextField(
                textCapitalization: TextCapitalization.sentences,
                focusNode: _focusNode3,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    hintText: 'Due Date',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    )),
                readOnly: true,
                onTap: () {
                  savedate();
                },
                controller: _datetimecontroller,
              ),
              AppSpacing.h10,
              // time picker
              TextField(
                textCapitalization: TextCapitalization.sentences,
                focusNode: _focusNode4,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.alarm,
                      color: Colors.white,
                    ),
                    hintText: 'Reminder',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    )),
                readOnly: true,
                onTap: () {
                  _selectTime(context);
                },
                controller: _timecontroller,
              ),

              AppSpacing.h10,

              AddTaskscreentile(
                leadingicon: Icons.flag_outlined,
                title: 'Priority',
                trailing: Container(
                  child: DropdownButton(
                    focusNode: _focusNode5,
                    iconEnabledColor: Colors.white,
                    dropdownColor: Color(0xFFEA82FF),
                    items: priority.map((String item) {
                      return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(color: Colors.white),
                          ));
                    }).toList(),
                    onChanged: (String? newvalue) {
                      setState(() {
                        selectedPriority = newvalue;
                      });
                    },
                    value: selectedPriority,
                  ),
                ),
                ontap: () {},
              ),

              const Divider(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color:Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: TextButton(
              onPressed: () {
                todoprovider.deleteTodo(taskid);
                Navigator.pop(context,true);
              },
              child: Customtext(
                text: 'DELETE',
                color: bottombuttoncolor,
                size: 18,
              ),
            )),
            Expanded(
                child: TextButton(
                    onPressed: () {
                      if (_taskcontroller.text.isNotEmpty &&
                          _datetimecontroller.text.isNotEmpty) {
                        final todo = Todoclass(
                          title: _taskcontroller.text.trim(),
                          dueDate: _datetimecontroller.text.trim(),
                          category: selectedValue ,
                          priority: selectedPriority ?? 'Low',
                          isCompleted: false,
                        );

                        todoprovider.updateTodo(taskid,todo).then((value) {
                          Navigator.pop(context); // Go back to previous screen
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                      const     SnackBar(
                            content: Text('Please fill all fields'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    },
                    child:  Customtext(
                      color: bottombuttoncolor,
                      text: 'CONFIRM',
                      size: 18,
                    )
                    )
                    )
          ],
        ),
      ),
    );
  }

// to pick date
  Future<void> savedate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        _datetimecontroller.text = _picked.toString().split(" ")[0];
      });
      FocusScope.of(context).requestFocus(_focusNode4);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final formattedTime = TimeOfDay(
        hour: pickedTime.hour,
        minute: pickedTime.minute,
      ).format(context);

      _timecontroller.text = formattedTime;

      // 👇 Move focus to next field
      FocusScope.of(context).requestFocus(_focusNode5);
    }
  }
}
