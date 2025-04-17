// import 'package:flutter/material.dart';

// class Categoryscreen extends StatelessWidget {
//   const Categoryscreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const   Color purpleColor = const Color(0xFFEA82FF);

//     return  Scaffold(
//       backgroundColor:const   Color(0xFFF8EDED),

//       body:SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,

//           children: [

//         Container(
//           color: purpleColor,
//           child: Stack(
//           alignment: Alignment.center,
//             children: [
//               Row(
//                 children: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.arrow_back_ios),
//           ),
//                 ],
//               ),
//               Center(
//                 child: Text(
//           'Work',
//           style: TextStyle(fontSize: 25),
//                 ),
//               ),
//             ],
//           ),
//         ),

// // Expanded(child: Container(
// //   height: double.infinity,

// // )
// // )

//     ]  )
//     ));
//   }
// }

import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  String category;
  final Color purpleColor = const Color(0xFFEA82FF);
  TaskPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EDED), // soft background
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              color: purpleColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.black)),
                const Spacer(),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Calendar Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                DayTile(day: "5", label: "Mon"),
                DayTile(day: "6", label: "Tue"),
                DayTile(day: "7", label: "Wen", isSelected: true),
                DayTile(day: "8", label: "Thu"),
                DayTile(day: "9", label: "Fri"),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Tasks
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              children: const [
                TaskCard(),
                SizedBox(height: 15),
                TaskCard(),
              ],
            ),
          ),

          // Add New Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEA82FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: const Text(
                  'Add New',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DayTile extends StatelessWidget {
  final String day;
  final String label;
  final bool isSelected;

  const DayTile({
    super.key,
    required this.day,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xFFF6D4FF), // lighter shade of purple
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Expanded(
                child: Text(
                  "Meeting with Team",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Icon(Icons.check_box, color: Colors.black),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.access_time, size: 16, color: Colors.black54),
              SizedBox(width: 4),
              Text("10 am", style: TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }
}
