import 'package:flutter/material.dart';
import 'package:task_mate2/util/consts.dart';

class CategoryScreen1 extends StatelessWidget {
  const CategoryScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        color:const Color(0xFFF1B9FF)
      ,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 120,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {},
                      child:const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
              const    Center(
                    child: Text('work', style: TextStyle(fontSize: 32)),
                  ),
                ],
              ),
            ),
            AppSpacing.h30,
            Expanded(
              child: Container(
                decoration:const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight:Radius.circular(40)
                        )
                ),
                height: double.infinity,
                width: double.infinity,
              
              ),
            ),
          ],
        ),
      ),
    );
  }
}
