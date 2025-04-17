// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class Todomainscreen extends StatefulWidget {
//   const Todomainscreen({super.key});

//   @override
//   State<Todomainscreen> createState() => _TodomainscreenState();
// }

// class _TodomainscreenState extends State<Todomainscreen> {
//   List<DateTime> dates = [];
//   int selectedIndex = 0;
//   late String formattedDate;
// final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _generateDates();
//     formattedDate = DateFormat('dd  MMMM').format(DateTime.now());
//     _setInitialSelectedDate();
//     _scrollToSelectedDate();
//   }

//   void _generateDates() {
//     DateTime today = DateTime.now();
//     for (int i = -30; i < 30; i++) {
//       dates.add(today.add(Duration(days: i)));
//     }
//   }

//   void _setInitialSelectedDate() {
//     DateTime today = DateTime.now();
//     for (int i = 0; i < dates.length; i++) {
//       if (isSameDate(dates[i], today)) {
//         selectedIndex = i;
//         break;
//       }
//     }
//   }

//   bool isSameDate(DateTime a, DateTime b) {
//     return a.year == b.year && a.month == b.month && a.day == b.day;
//   }

//   void _scrollToSelectedDate() {
//     double itemWidth = 100; // approx width of each date item (tweak if needed)
//     _scrollController.animateTo(
//       selectedIndex * itemWidth,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0),
//               child: Text(formattedDate),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               height: 100,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: dates.length,
//                 itemBuilder: (context, index) {
//                   bool isSelected = index == selectedIndex;
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = index;
//                       });
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       margin: const EdgeInsets.symmetric(horizontal: 8),
//                       decoration: BoxDecoration(
//                         color: isSelected
//                             ? const Color.fromARGB(255, 208, 68, 232)
//                             : Colors.grey[300],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             DateFormat('d').format(dates[index]),
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: isSelected ? Colors.white : Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             DateFormat('EEE').format(dates[index]),
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                               color: isSelected ? Colors.white : Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class Todomainscreen extends StatefulWidget {
//   const Todomainscreen({super.key});

//   @override
//   State<Todomainscreen> createState() => _TodomainscreenState();
// }

// class _TodomainscreenState extends State<Todomainscreen> {
//   List<DateTime> dates = [];
//   int selectedIndex = 0;
//   late String formattedDate;
//   final ScrollController _scrollController = ScrollController();
//   final double itemWidth = 90; // Adjust based on your item size

//   @override
//   void initState() {
//     super.initState();
//     _generateDates();
//     formattedDate = DateFormat('dd  MMMM').format(DateTime.now());
//     _setInitialSelectedDate();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollToCenter();
//     });
//   }

//   void _generateDates() {
//     DateTime today = DateTime.now();
//     for (int i = -30; i < 30; i++) {
//       dates.add(today.add(Duration(days: i)));
//     }
//   }

//   void _setInitialSelectedDate() {
//     DateTime today = DateTime.now();
//     for (int i = 0; i < dates.length; i++) {
//       if (_isSameDate(dates[i], today)) {
//         selectedIndex = i;
//         break;
//       }
//     }
//   }

//   bool _isSameDate(DateTime a, DateTime b) {
//     return a.year == b.year && a.month == b.month && a.day == b.day;
//   }

//   void _scrollToCenter() {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double offset = (itemWidth * selectedIndex) - (screenWidth / 2) + (itemWidth / 2);

//     // Clamp to avoid negative scroll
//     offset = offset.clamp(0, _scrollController.position.maxScrollExtent);

//     _scrollController.animateTo(
//       offset,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.only(left: 20.0),
//             child: Text(formattedDate),
//           ),
//           const SizedBox(height: 20),
//           SizedBox(
//             height: 100,
//             child: ListView.builder(
//               controller: _scrollController,
//               scrollDirection: Axis.horizontal,
//               itemCount: dates.length,
//               itemBuilder: (context, index) {
//                 bool isSelected = index == selectedIndex;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = index;
//                     });
//                     _scrollToCenter();
//                   },
//                   child: Container(
//                     width: itemWidth,
//                     margin: const EdgeInsets.symmetric(horizontal: 8),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? const Color.fromARGB(255, 208, 68, 232)
//                           : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           DateFormat('d').format(dates[index]),
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: isSelected ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           DateFormat('EEE').format(dates[index]),
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: isSelected ? Colors.white : Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_mate2/widgets/tododateselector.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
 late String formattedDate;
  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('dd  MMMM').format(DateTime.now());
  }
  @override
  Widget build(BuildContext context) {
    
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      body: Column(
     //mainAxisAlignment:  MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(formattedDate),
        DateScroller(onDateSelected:(p0) => DateTime.now(),)
      
          // Your task list here for selectedDate
        ],
      ),
    );
  }
}
