import 'package:flutter/material.dart';

class ShowDialoges extends StatelessWidget {
  TextEditingController categoryController = TextEditingController();

  ShowDialoges({super.key, required this.categoryController});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:const Text('Add New Category'),
      content: TextField(
        controller: categoryController,
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child:const Text('Save')) 
      ],

    );
  }
}
