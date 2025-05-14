import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:task_mate2/features/pofile&settings/services/logoutservice.dart';
import 'package:task_mate2/features/todo_screen/view_model/todo_viewmodel.dart';
import 'package:task_mate2/util/consts.dart';

class Hmdrawer extends StatelessWidget {
   Hmdrawer({super.key});
Logoutservice _logoutservice =Logoutservice();
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<TodoViewModel>();
    final user = userProvider.user;
    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(children: [
          DrawerHeader(
            decoration:
                const BoxDecoration(
                 // color: Color.fromARGB(255, 122, 191, 247)
                  ),
            child: Column(
              children: [
                Column(
                  children: [
                    Consumer<TodoViewModel>(builder: (context, value, _) {
                    final user= value.user;
                    return  CircleAvatar(
                          backgroundImage:user?.profileimage==null?const AssetImage('assets/istockphoto-1337144146-612x612.jpg'): NetworkImage('${user?.profileimage}'),
                        radius: 50,
                      );
    }  ),
                    AppSpacing.h10,
                    Text(user?.name.toString() ?? '')
                  ],
                ),
              ],
            ),
          ),
          buildCustomTile(icon: Icons.person, title: 'Profile', onTap: (){
            Navigator.pushNamed(context,'/profilecsreen');
          }),
            buildCustomTile(icon:Icons.settings, title: 'Settings', onTap: (){
              Navigator.pushNamed(context, '/settingspage');
            }),
              buildCustomTile(icon: Icons.info, title: 'About', onTap: (){
                Navigator.pushNamed(context, '/aboutpage');
              }),
                buildCustomTile(icon: Icons.share, title: 'Invite Friends', onTap: ()async{
          await    await Share.share(
      'Check out TaskMate — your personal task manager!\nhttps://yourappurl.com',
      subject: 'Try TaskMate App!',
    );
                }),
                  buildCustomTile(icon: Icons.person, title: 'SignOut', onTap: (){
                    _logoutservice.logout(context);
                  }),
      
      
        ]));
  }
  Widget buildCustomTile({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: ListTile(
      leading: Icon(icon),
      title: Text(title),
    ),
  );
}
}
