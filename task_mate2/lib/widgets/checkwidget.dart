

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:task_mate2/widgets/tododateselector.dart';

// class TodoPage extends StatefulWidget {
//   const TodoPage({super.key});

//   @override
//   State<TodoPage> createState() => _TodoPageState();
// }

// class _TodoPageState extends State<TodoPage> {
//  late String formattedDate;
//   @override
//   void initState() {
//     super.initState();
//     formattedDate = DateFormat('dd  MMMM').format(DateTime.now());
//   }
//   @override
//   Widget build(BuildContext context) {
    
//     DateTime selectedDate = DateTime.now();

//     return Scaffold(
//       body: Column(
//      //mainAxisAlignment:  MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//         Text(formattedDate),
//         DateScroller(onDateSelected:(p0) => DateTime.now(),)
      
//           // Your task list here for selectedDate
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:task_mate2/util/consts.dart';
import 'package:task_mate2/widgets/custom_tile_widget.dart';
import 'package:task_mate2/widgets/customtext.dart';
import 'package:task_mate2/widgets/tododateselector.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color:const Color(0xFFEA82FF),
          child: Padding(
            padding: const EdgeInsets.only(top: 70,
            left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
            //  mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon:const Icon(Icons.arrow_back)),
            const     SizedBox(width: 100,),
                    const      Customtext(text: 'Category')
              ],
            ),
          ),

          ),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              
              width: double.infinity,
              decoration:const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35)),),
            child: Column(
              children: [
                AppSpacing.h10,
                DateScroller(onDateSelected:(p0)=>DateTime.now()),
                Expanded(
                  child: ListView.builder(itemBuilder: (context, index) {
                    return const Column(
                      children: [
                    
                      ],
                    );
                  },
                  itemCount: 15,
                  ),
                )
            
              ],
            ),
            
            
              ),

              
            

          )

        ],
      ),
    );
  }
}
