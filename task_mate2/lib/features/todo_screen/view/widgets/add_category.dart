import 'package:flutter/material.dart';

class ShowDialoges extends StatelessWidget {
  TextEditingController categoryController = TextEditingController();
 final Function onTap ;

  ShowDialoges({super.key, required this.categoryController, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:const Text('Add New Category'),
      content: TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: categoryController,
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
          onTap();
        }, child:const Text('Save'))
      ],

    );
  }
}
