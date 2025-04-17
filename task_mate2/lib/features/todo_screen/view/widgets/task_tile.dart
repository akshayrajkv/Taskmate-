import 'package:flutter/material.dart';


class Tasktile extends StatefulWidget {
  String title;
  bool isChecked;

  Tasktile({
    super.key,
    required this.title,
    required this.isChecked,
  });

  @override
  State<Tasktile> createState() => _TasktileState();
}

class _TasktileState extends State<Tasktile> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) {
        //     return Todoscreen(isChecked: isChecked, title: 'snnd');
        //   },
        // ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 22,right: 22,bottom: 20),
        child: Material(
          elevation: 4,
          child: Container(
            
            height: 75,
            decoration: BoxDecoration(
            
              color: const Color.fromARGB(146, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
            
            ),
            child: ListTile(
              
                // leading: Icon(
                //   Icons.pending_actions_rounded,
                //   color: Color.fromARGB(255, 235, 139, 132),
                // ),
                title: Text(widget.title),
                trailing: Checkbox(
                  value: widget.isChecked,
                  onChanged: (value) {
                    setState(() {
                      widget.isChecked = !widget.isChecked;
                    });
                  },
                )),
          ),
        ),
      ),
    );
  }
}
