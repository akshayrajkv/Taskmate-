import 'package:flutter/material.dart';

class Drawerwidget extends StatelessWidget {
  const Drawerwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
            children: [
              Text('user name'),
              Text('account'),
              Text('logout')
            ],
      ),
      
    
    );
  }
}