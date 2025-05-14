import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate2/features/apps_pages/view/about_page.dart';
import 'package:task_mate2/features/apps_pages/view/settings_page.dart';
import 'package:task_mate2/features/auth/view/login_screen.dart';
import 'package:task_mate2/features/auth/view/register_screen.dart';
import 'package:task_mate2/features/auth/view/splashscreen.dart';
import 'package:task_mate2/features/auth/view_model/auth_viewmodel.dart';
import 'package:task_mate2/features/pofile&settings/view/profilepage.dart';
import 'package:task_mate2/features/todo_screen/view/add_todoscreen.dart';
import 'package:task_mate2/features/todo_screen/view/all_todo_screen.dart';
import 'package:task_mate2/features/todo_screen/view/home_screen.dart';
import 'package:task_mate2/features/todo_screen/view_model/todo_viewmodel.dart';


void main() {
    WidgetsFlutterBinding.ensureInitialized();
  runApp(
  
  MultiProvider(providers: [
ChangeNotifierProvider(create: (_) => AuthViewModel(),),
ChangeNotifierProvider(create: (_)=>TodoViewModel(),),
  ],
  child:const  MyApp(),)
  
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/':(context)=>const Splashscreen(),
        '/loginscreen':(context)=>LoginScreen(),
        '/singupscreen':(context)=>SignupScreen(),
        '/homescreen':(context)=> Homescreen(),
        '/addtodoscreen':(context)=>const AddTodoscreen(),
        '/profilecsreen':(context)=> Profilepage(),
        '/settingspage':(context)=>const SettingsPage(),
        '/aboutpage':(context)=>const AboutPage(),
        '/alltodopage':(context)=>const AllTodoScreen(),
      
      },
      initialRoute: '/',
      // home:const Home()
    
    );
  }
}
