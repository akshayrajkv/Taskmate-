import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate2/features/todo_screen/view/categoryscreen.dart';
import 'package:task_mate2/features/todo_screen/view/widgets/add_category.dart';
import 'package:task_mate2/features/todo_screen/view/widgets/category_tile.dart';
import 'package:task_mate2/features/todo_screen/view/widgets/hmdrawer.dart';
import 'package:task_mate2/features/todo_screen/view/widgets/taskcontainer.dart';
import 'package:task_mate2/features/todo_screen/view_model/todo_viewmodel.dart';
import 'package:task_mate2/util/consts.dart';
import 'package:task_mate2/widgets/customtext.dart';

class Homescreen extends StatefulWidget {
  Homescreen({
    super.key,
  });

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
//  List<String>? categoryList ;
  TextEditingController _controller = TextEditingController();
  List<Color> tileColors = [
    const Color.fromARGB(255, 231, 81, 16),
    const Color.fromARGB(255, 232, 220, 110),
    const Color.fromARGB(255, 140, 220, 143),
    const Color.fromARGB(255, 231, 81, 16),
    const Color.fromARGB(255, 232, 220, 110),
    const Color.fromARGB(255, 140, 220, 143),
    const Color.fromARGB(255, 231, 81, 16),
    const Color.fromARGB(255, 232, 220, 110),
    const Color.fromARGB(255, 140, 220, 143),
  ];

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewmodel = Provider.of<TodoViewModel>(context, listen: false);
      if (viewmodel.user == null) {
        viewmodel.userdetail();
      }
      if (viewmodel.categories == null) {
        viewmodel.loadAllCategories();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = context.watch<TodoViewModel>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      drawer: Hmdrawer(),
      //AppBar
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ));
        }),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: Consumer<TodoViewModel>(
          builder: (context, userprovider, _) {
            if (userprovider.isLoading) {
              return const CircularProgressIndicator();
            }
            if (userprovider.user == null) {
              return const Text("");
            }
            return Text(
              "HI ${userprovider.user!.name.toString()}!",
              style: const TextStyle(color: Colors.white),
            );
          },
        ),
        actions: const [AppSpacing.w10],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            AppSpacing.h20,
            Padding(
              padding: const EdgeInsets.all(15.0),
              // search bar

              child: TextField(
                decoration: InputDecoration(
                  suffixIcon:
                      InkWell(onTap: () {}, child: const Icon(Icons.search)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  fillColor: Colors.white60,
                  filled: true,
                ),
              ),
            ),
            AppSpacing.h10,
            const Padding(
              padding: EdgeInsets.only(left: 15),

              // category

              child: Customtext(
                text: 'Category',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                  height: 175,
                  child: Consumer<TodoViewModel>(
                    builder: (context, viewModel, _) {
                      final categories = viewModel.categories ?? [];

                      if (viewModel.isLoading && categories.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return SizedBox(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length + 1,
                          itemBuilder: (context, index) {
                            if (index == categories.length) {
                              return Catagorytile(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ShowDialoges(
                                        categoryController: _controller,
                                        onTap: () async {
                                          await viewModel
                                              .addnewcategory(_controller.text);
                                        },
                                      );
                                    },
                                  );
                                },
                                catogoryitem: 'Add',
                              );
                            } else {
                              return Catagorytile(
                                catogoryitem: categories[index],
                                color: tileColors[index],
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CategoryPage(
                                              categoryy: categories[index])));
                                },
                              );
                            }
                          },
                        ),
                      );
                    },
                  )),
            ),
            AppSpacing.h30,
            Expanded(
              child: Taskcontainer(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addtodoscreen');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
