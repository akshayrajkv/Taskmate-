import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_mate2/features/todo_screen/model/todomodel.dart';
import 'package:task_mate2/features/todo_screen/model/userdetailmodel.dart';
import 'package:task_mate2/features/todo_screen/repository/classtodorepo.dart';


class TodoViewModel with ChangeNotifier {
  final Todorepo _todoRepo= Todorepo();
  Usermodel? user;
  bool isLoading = false;
  List<Todoclass>? todos;
  List<Todoclass>?catecorytodos;
  List<String>? categories;
  List<String>? usercategories;

//get user
  Future<void>userdetail()async{
    try{
      isLoading = true;
      notifyListeners();
    final getuser = await _todoRepo.getUser();
    user=getuser;
    }
    catch(e){
      print(e);
  }
  isLoading=false;
  notifyListeners();
  }

  // feach todo

 Future<void> fetchTodos() async {
  isLoading = true;
  notifyListeners();
  try {
    final fetchedTodos = await _todoRepo.getTodos(); // Replace with your actual fetch logic
    todos = fetchedTodos;
  } catch (e) {
    print("Error fetching todos: $e");
  }

  isLoading = false;
  notifyListeners();
}

  
    Future<bool> addTodo(Todoclass todo) async {
    bool success = await _todoRepo.createTodo(todo);
    if (success=true) {
      print ("success");
      await fetchTodos();
      notifyListeners();// Refresh list after adding
    }
    return success;
  }

// get all categories

Future<void>getAllcategory()async{
    try{
  isLoading = true;
  notifyListeners();

    final allcategories = await _todoRepo.getallcategories();
    categories = allcategories;
    print("the categoryies are : ${ categories}");
  }catch(e){
  print(e);
  }
  isLoading = false;
  notifyListeners();
}

//feach user category

Future<void>getUsercategory()async{
    try{
  isLoading = true;
  notifyListeners();

    final allcategories = await _todoRepo.getUsercategories();
    usercategories = allcategories;
    print("the user categoryies are : ${ categories}");
  }catch(e){
  print(e);
  }
  isLoading = false;
  notifyListeners();
}

//feach todos based on category
Future <void> fetchCatgoryTodos(String category) async {
  isLoading = true;
  notifyListeners();
  try {
    final fetchedCategoryTodos = await _todoRepo.getCategoryTodos(category); // Replace with your actual fetch logic
    catecorytodos = fetchedCategoryTodos;
  } catch (e) {
    print("Error fetching todos: $e");
  }

  isLoading = false;
  notifyListeners();
}

Future <void>addnewcategory(String newcategory)async{

  try {
    await _todoRepo.addnewcategory(newcategory);
    
      print("added");
  }catch(e){
    print(e);
  
}

}
}
