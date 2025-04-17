import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_mate2/features/auth/model/usermodel.dart';
import 'package:task_mate2/features/todo_screen/model/todomodel.dart';
import 'package:task_mate2/features/todo_screen/model/userdetailmodel.dart';
import 'package:task_mate2/features/todo_screen/repository/classtodorepo.dart';


class TodoViewModel with ChangeNotifier {
  final Todorepo _todoRepo= Todorepo();
  Usermodel? user;
  bool isLoading = false;
  List<Todoclass>? todos;
  List<String>? categories;

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
  }catch(e){
  print(e);
  }
  isLoading = false;
  notifyListeners();
}

 Future<void> fetchCatgoryTodos(String category) async {
  isLoading = true;
  notifyListeners();
  try {
    final fetchedCategoryTodos = await _todoRepo.getCategoryTodos(category); // Replace with your actual fetch logic
    todos = fetchedCategoryTodos;
  } catch (e) {
    print("Error fetching todos: $e");
  }

  isLoading = false;
  notifyListeners();
}


}
