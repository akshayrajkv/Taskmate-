
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate2/features/pofile&settings/view/profilepage.dart';
import 'package:task_mate2/features/todo_screen/view/categoryscreen.dart';
import 'package:task_mate2/features/todo_screen/view/widgets/add_category.dart';
import 'package:task_mate2/features/todo_screen/view/widgets/category_tile.dart';
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

  int selectedindex = 0;
  // bool isChecked =false;
  final List<Widget> _screens = [
    Homescreen(),
    Profilepage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewmodel = Provider.of<TodoViewModel>(context, listen: false);
      viewmodel.userdetail();
      viewmodel.getAllcategory();
    });
  }

  @override
  Widget build(BuildContext context) {
      final userProvider = context.watch<TodoViewModel>();
  final user = userProvider.user;
    return  Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
    drawer:   Drawer(
      backgroundColor: Colors.white,
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 122, 191, 247)),
                      child:Column(
                        children: [
                          Column(
                            children: [
                            const  CircleAvatar(
                                radius: 50,
                              ),
                              AppSpacing.h10,
                              Text("${user?.name.toString()??''}")
                            ],
                          ),
                        ],
                      ),),
                  const ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                  ),
            const         ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
              const     Column(
                    children: [
                        ListTile(
                                      leading: Icon(Icons.logout),
                                      title: Text('Logout'),
                                    ),
                    ],
                  ),

            
                      
                  ],
                ),
              ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();

            
            }, icon:Icon(Icons.menu,color: Colors.white,
            ));
          }
        ),
    
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
        actions: const [
    
          AppSpacing.w10
        ],
      ),
    
      body:
    
      Container(
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
                  height: 200,
                  child: Consumer<TodoViewModel>(
                    builder: (context, viewModel, _) {
                      final categories = viewModel.categories ?? [];

                      if (viewModel.isLoading && categories.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return SizedBox(
                      //  height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length + 1,
                          itemBuilder: (context, index) {
                            if (index == categories.length) {
                              return Catagorytile(
                                onTap: () {
                                  showDialog(context: context, builder:(context) {
                                    return ShowDialoges(categoryController:_controller );
                                  },);
                                
                                },
                                catogoryitem: 'Add',
                              );
                            } else {
                              return Catagorytile(

                                catogoryitem: categories[index],
                                color: tileColors[index],
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>CategoryPage(categoryy: categories[index])
                                  )
                                  );
                                },
                              );
                            }
                          },
                        ),
                      );
                    },
                  )

              
                  ),
            ),
            AppSpacing.h30,
            Expanded(
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.5,
                maxChildSize: 1,
                builder: (context, scrollController) {
                  return Taskcontainer(
                    scrollController: scrollController,
                  );
                },
              ),
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
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar:
          BottomNavigationBar(currentIndex: selectedindex, items:const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile'),
      ]),
    );
  }
}
