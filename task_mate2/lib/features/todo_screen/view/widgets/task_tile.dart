
import 'package:flutter/material.dart';
import 'package:task_mate2/widgets/customtext.dart';

class Tasktile extends StatefulWidget {
  String title;
  bool isChecked;
  VoidCallback onTap;

  Tasktile({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onTap,
  });

  @override
  State<Tasktile> createState() => _TasktileState();
}

class _TasktileState extends State<Tasktile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22, bottom: 20),
      child: Material(
      elevation: 4,
        borderRadius: BorderRadius.circular(10), 
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 4, 76, 135),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Customtext(text:  widget.title,color: Colors.white,size: 20,),
                    Checkbox(
                      value: widget.isChecked,
                      onChanged: (value) {
                        setState(() {
                          widget.isChecked = value ?? false;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
