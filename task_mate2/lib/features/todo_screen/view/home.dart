import 'package:flutter/material.dart';
import 'package:task_mate2/features/pofile&settings/view/profilepage.dart';
import 'package:task_mate2/features/todo_screen/view/habit_screen.dart';
import 'package:task_mate2/features/todo_screen/view/home_screen.dart';
import 'package:task_mate2/features/todo_screen/view/timer_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedindex = 0;
  // bool isChecked =false;
  final List screens = [
    Homescreen(),
    HabitScreen(),
    TimerScreen(),
    Profilepage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedindex],

      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              const Color.fromARGB(255, 155, 22, 179), // Background color
          selectedItemColor: Colors.white, // Color of selected item
          unselectedItemColor: Colors.grey.shade400,
          currentIndex: selectedindex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes),
              label: 'Habit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Timer',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ]),
   
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
