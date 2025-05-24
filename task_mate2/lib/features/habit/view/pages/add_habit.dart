import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate2/features/habit/view/pages/habit_repeat_page.dart';
import 'package:task_mate2/features/todo_screen/model/todomodel.dart';
import 'package:task_mate2/features/todo_screen/view/widgets/add_taskscreentile.dart';
import 'package:task_mate2/features/todo_screen/view_model/todo_viewmodel.dart';
import 'package:task_mate2/util/consts.dart';
import 'package:task_mate2/widgets/customtext.dart';
class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  String? selectedPriority = 'Low';
  String? selectedValue;

  final TextEditingController _habitcontroller = TextEditingController();
  final TextEditingController _datetimecontroller = TextEditingController();
  final TextEditingController _timecontroller = TextEditingController();

  final List<String> priorityOptions = ['Low', 'Medium', 'High'];

  Future<void> savedate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _datetimecontroller.text =
            pickedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timecontroller.text = picked.format(context);
      });
    }
  }

  @override
  void dispose() {
    _habitcontroller.dispose();
    _datetimecontroller.dispose();
    _timecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: backgroundColor,
        ),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              // Habit input
              TextField(
                controller: _habitcontroller,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Habit',
                  hintStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              AppSpacing.h20,
              const Divider(color: Colors.white),

              // Category tile
              AddTaskscreentile(
                leadingicon: Icons.category,
                title: 'Category',
                trailing: Consumer<TodoViewModel>(
                  builder: (context, value, _) {
                    final category = value.categories;
                    if (selectedValue == null && category!.isNotEmpty) {
                      selectedValue = category[0];
                    }

                    return DropdownButton(
                      iconEnabledColor: Colors.white,
                      dropdownColor: const Color(0xFFEA82FF),
                      value: selectedValue,
                      items: category?.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item, style: const TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                    );
                  },
                ),
                ontap: () {},
              ),
           

              const Divider(),
              TextField(
                controller: _datetimecontroller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.loop, color: Colors.white),
                  hintText: 'How often do you want to do it ?',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                readOnly: true,
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                    return const HabitRepeatPage();
                  },));
                }
              ),

              AppSpacing.h10,
              TextField(
                controller: _datetimecontroller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.date_range, color: Colors.white),
                  hintText: 'Start date',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                readOnly: true,
                onTap: savedate,
              ),

              // Date Picker
              TextField(
                controller: _datetimecontroller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.date_range, color: Colors.white),
                  hintText: 'End Date',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                readOnly: true,
                onTap: savedate,
              ),

              AppSpacing.h10,

              // Time Picker
              TextField(
                controller: _timecontroller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.alarm, color: Colors.white),
                  hintText: 'Reminder',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectTime(context),
              ),

              AppSpacing.h10,

              // Priority tile
              AddTaskscreentile(
                ontap: () {},
                leadingicon: Icons.flag_outlined,
                title: 'Priority',
                trailing: DropdownButton(
                  iconEnabledColor: Colors.white,
                  dropdownColor: const Color(0xFFEA82FF),
                  value: selectedPriority,
                  items: priorityOptions.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPriority = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom bar
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: const Color(0xFFEA82FF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Customtext(text: 'CANCEL', size: 18),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  if (_habitcontroller.text.isNotEmpty &&
                      _datetimecontroller.text.isNotEmpty) {
                    final todo = Todoclass(
                      title: _habitcontroller.text.trim(),
                      dueDate: _datetimecontroller.text.trim(),
                      category: selectedValue ?? 'Work',
                      priority: selectedPriority ?? 'Low',
                      isCompleted: false,
                    );

                    final todoprovider =
                        Provider.of<TodoViewModel>(context, listen: false);
                    todoprovider.addTodo(todo).then((value) {
                      Navigator.pop(context);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all fields'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                child: const Customtext(text: 'CONFIRM', size: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
