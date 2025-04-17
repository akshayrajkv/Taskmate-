// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class TodoDateSelector extends StatefulWidget {
//   final Function(DateTime) onDateSelected;

//   const TodoDateSelector({super.key, required this.onDateSelected});

//   @override
//   State<TodoDateSelector> createState() => _TodoDateSelectorState();
// }

// class _TodoDateSelectorState extends State<TodoDateSelector> {
//   DateTime selectedDate = DateTime.now();

//   List<DateTime> getWeekDates() {
//     final today = DateTime.now();
//     return List.generate(21, (index) => today.subtract(Duration(days: 10 - index)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dates = getWeekDates();

//     return SizedBox(
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: dates.length,
//         itemBuilder: (context, index) {
//           final date = dates[index];
//           final isSelected = DateUtils.isSameDay(date, selectedDate);
//           final dayName = DateFormat('EEE').format(date); // Mon, Tue...
//           final dayNumber = date.day;

//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 selectedDate = date;
//               });
//               widget.onDateSelected(date); // Callback to parent
//             },
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: isSelected ? Colors.purpleAccent : Colors.grey[300],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('$dayNumber', style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
//                   const SizedBox(height: 4),
//                   Text(dayName,
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: isSelected ? Colors.white : Colors.black)),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateScroller extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const DateScroller({super.key, required this.onDateSelected});

  @override
  State<DateScroller> createState() => _DateScrollerState();
}

class _DateScrollerState extends State<DateScroller> {
  DateTime selectedDate = DateTime.now();
  late List<DateTime> dateRange;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    dateRange = getDateRangeAroundSelected(selectedDate);
    _scrollController = ScrollController();

    // Center the selected index after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double itemWidth = 80; // Width + padding/margin of each item
      double scrollTo = (10 * itemWidth) - (MediaQuery.of(context).size.width / 2) + (itemWidth / 2);
      _scrollController.jumpTo(scrollTo);
    });
  }

  List<DateTime> getDateRangeAroundSelected(DateTime date) {
    return List.generate(21, (index) => date.subtract(Duration(days: 10 - index)));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: dateRange.length,
        itemBuilder: (context, index) {
          final date = dateRange[index];
          final isSelected = DateUtils.isSameDay(date, selectedDate);
          final isToday = DateUtils.isSameDay(date, DateTime.now());

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
              widget.onDateSelected(date);
            },
            child: Container(
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.purple
                    : isToday
                        ? Colors.blueAccent
                        : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${date.day}',
                      style: TextStyle(color: isSelected || isToday ? Colors.white : Colors.black)),
                  const SizedBox(height: 4),
                  Text(DateFormat('EEE').format(date),
                      style: TextStyle(
                          color: isSelected || isToday ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

