import 'package:flutter/material.dart';
import 'package:task_mate2/features/pofile&settings/view/profilepage.dart';
import 'package:task_mate2/features/todo_screen/view/home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int selectedindex = 0;
  // bool isChecked =false;

  void _onItemTapped(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
              body: selectedindex==0?Homescreen():Profilepage(),

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedindex,
          onTap: _onItemTapped,
          items:const [
              BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon:  InkWell(
            
                  child: Icon(Icons.person)),
                label: 'profile'),
          ]),
              floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addtodoscreen');
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,);
    
    
  }
}