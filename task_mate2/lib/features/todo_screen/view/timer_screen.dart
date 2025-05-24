// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:task_mate2/util/consts.dart';
// import 'package:task_mate2/widgets/customtext.dart';

// void main() => runApp(MaterialApp(home: TimerScreen()));

// class TimerScreen extends StatefulWidget {
//   @override
//   _TimerScreenState createState() => _TimerScreenState();
// }

// class _TimerScreenState extends State<TimerScreen> with TickerProviderStateMixin {

//   late TabController _tabController;
//   Stopwatch _stopwatch = Stopwatch();
//   late Timer _timer;
//   String _displayTime = "00:00";

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateTime());
//   }

//   void _updateTime() {
//     if (_stopwatch.isRunning) {
//       final minutes = _stopwatch.elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
//       final seconds = _stopwatch.elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
//       setState(() {
//         _displayTime = "$minutes:$seconds";
//       });
//     }
//   }

//   void _startStopwatch() {
//     _stopwatch.start();
//   }

//   void _resetStopwatch() {
//     _stopwatch.reset();
//     setState(() {
//       _displayTime = "00:00";
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// extendBodyBehindAppBar: true,

//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title:const Customtext(text: 'Timer'),
//         backgroundColor: Colors.transparent,

//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration:const BoxDecoration(
//           gradient: backgroundColor
//         ),
//         child: Column(
//           children: [
//         const    SizedBox(height: 150),
//             Center(
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 8),
//                 ),
//                 child: Center(
//                   child: Text(
//                     _displayTime,
//                     style: TextStyle(fontSize: 40, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             ElevatedButton.icon(
//               onPressed: _startStopwatch,
//               icon: Icon(Icons.play_arrow),
//               label: Text("START"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//               ),
//             ),
//       const      SizedBox(height: 30),
//             TabBar(
//               controller: _tabController,
//               labelColor: const Color.fromARGB(255, 6, 62, 107),
//               unselectedLabelColor: Colors.white,
//               indicatorColor: const Color.fromARGB(255, 6, 62, 107),
//               tabs: const [
//                 Tab(icon: Icon(Icons.timer), text: "Stopwatch"),
//                 Tab(icon: Icon(Icons.hourglass_bottom), text: "Countdown"),

//               ],
//             ),
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildRecordSection(),
//                   Center(child: Text("Countdown Tab", style: TextStyle(color: Colors.white))),
//                 //  Center(child: Text("Intervals Tab", style: TextStyle(color: Colors.white))),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRecordSection() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Card(
//         color: Colors.grey.shade900,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: ListTile(
//           leading: Icon(Icons.timer, color: Colors.white),
//           title: Text("Last record", style: TextStyle(color: Colors.white70)),
//           subtitle: Text(_displayTime, style: TextStyle(color: Colors.white, fontSize: 18)),
//           trailing: IconButton(
//             icon: Icon(Icons.close, color: Colors.white),
//             onPressed: _resetStopwatch,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_mate2/util/consts.dart'; // Optional, remove if not using
import 'package:task_mate2/widgets/customtext.dart'; // Optional, replace with Text()

void main() => runApp(MaterialApp(home: TimerScreen()));

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  bool isRunning = false;
  late TabController _tabController;
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _displayTime = "00:00";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    if (_stopwatch.isRunning) {
      final minutes =
          _stopwatch.elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
      final seconds =
          _stopwatch.elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
      setState(() {
        _displayTime = "$minutes:$seconds";
      });
    }
  }

  void _startStopwatch() {
    _stopwatch.start();
    setState(() {
      isRunning = true;
    });
  }

  void _pauseStopwatch() {
    _stopwatch.stop();
    setState(() {
      isRunning = false;
    });
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {
      _displayTime = "00:00";
      isRunning = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Customtext(text: 'Timer'), // You can use Text("Timer") instead
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
        image: DecorationImage(image: backgroundimage,fit: BoxFit.cover)
        // Replace or remove if not using custom gradient
        ),
        child: Column(
          children: [
            const SizedBox(height: 150),
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 8),
                ),
                child: Center(
                  child: Text(
                    _displayTime,
                    style:const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
            ),
        const    SizedBox(height: 30),

            // Start / Pause Button
            ElevatedButton.icon(
              onPressed: () {
                if (_stopwatch.isRunning) {
                  _pauseStopwatch();
                } else {
                  _startStopwatch();
                }
              },
              icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
              label: Text(isRunning ? "PAUSE" : "START"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding:const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            ),

          const  SizedBox(height: 20),

            // Reset Button
            ElevatedButton.icon(
              onPressed: _resetStopwatch,
              icon:const Icon(Icons.stop),
              label:const Text("RESET"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding:const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            ),

            const SizedBox(height: 30),
            TabBar(
              controller: _tabController,
              labelColor: const  Color.fromARGB(255, 10, 129, 226),
              unselectedLabelColor: Colors.white,
              indicatorColor: const Color.fromARGB(255, 10, 129, 226),
              tabs: const [
                Tab(icon: Icon(Icons.timer), text: "Stopwatch"),
                Tab(icon: Icon(Icons.hourglass_bottom), text: "Countdown"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildRecordSection(),
                const Center(
                      child: Text("Countdown Tab",
                          style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.grey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading:const Icon(Icons.timer, color: Colors.white),
          title:const Text("Last record", style: TextStyle(color: Colors.white70)),
          subtitle: Text(_displayTime,
              style:const  TextStyle(color: Colors.white, fontSize: 18)),
          trailing: IconButton(
            icon:const Icon(Icons.close, color: Colors.white),
            onPressed: _resetStopwatch,
          ),
        ),
      ),
    );
  }
}
