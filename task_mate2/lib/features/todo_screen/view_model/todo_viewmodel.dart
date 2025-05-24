import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_mate2/features/todo_screen/model/todomodel.dart';
import 'package:task_mate2/features/todo_screen/model/userdetailmodel.dart';
import 'package:task_mate2/features/todo_screen/repository/classtodorepo.dart';

class TodoViewModel with ChangeNotifier {
  final Todorepo _todoRepo = Todorepo();
  Usermodel? user;
  bool isLoading = false;
  List<Todoclass>? todos;
  List<Todoclass>? categorytodos;
  List<String>? categories;
  List<String>? usercategories;
  List<Todoclass> filtertasks = [];

//get user
  Future<void> userdetail() async {
    try {
      isLoading = true;
      notifyListeners();
      final getuser = await _todoRepo.getUser();
      user = getuser;
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateuser(String profileimage) async {
    try {
      isLoading = true;
      notifyListeners();
      await _todoRepo.updateuser(profileimage);
      userdetail();
    } catch (e) {
      print("error in updating");
    }
  }

  // feach todo

  Future<void> fetchTodos() async {
    isLoading = true;
    notifyListeners();
    try {
      final fetchedTodos =
          await _todoRepo.getTodos(); // Replace with your actual fetch logic
      todos = fetchedTodos;
    } catch (e) {
      print("Error fetching todos: $e");
    }

    isLoading = false;
    notifyListeners();
  }

// filtet task by due date

  void filtertaskbyduedate(String dueDate) {
    DateTime selectedDate = DateTime.parse(dueDate);

    filtertasks = todos!.where((task) {
      DateTime taskDate = DateTime.parse(task.dueDate.toString());
      return taskDate.year == selectedDate.year &&
          taskDate.month == selectedDate.month &&
          taskDate.day == selectedDate.day;
    }).toList();

    notifyListeners();
  }

  Future<bool> addTodo(Todoclass todo) async {
    bool success = await _todoRepo.createTodo(todo);
    if (success = true) {
      print("success");
      await fetchTodos();
      notifyListeners();
      filtertaskbyduedate(DateFormat('yyyy-MM-dd').format(DateTime.now()));
      // Refresh list after adding
    }
    return success;
  }

// update todo

  Future<bool> updateTodo(String taskid, Todoclass todo) async {
    try {
      bool success = await _todoRepo.updateTodo(taskid, todo);
      if (success == true) {
        await fetchTodos();
        notifyListeners();
      }
      return success;
    } catch (e) {
      print("error in updating $e");
      return false;
    }
  }

  //delete a todo
  Future<void> deleteTodo(String taskid) async {
    try {
      await _todoRepo.deleteTodo(taskid);
      fetchTodos();
      notifyListeners();
      filtertaskbyduedate(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    } catch (e) {
      print("delete error :$e");
    }
  }

  Future<void> loadAllCategories() async {
    try {
      isLoading = true;
      notifyListeners();

      final defaultCategories = await _todoRepo.getallcategories();
      usercategories = await _todoRepo.getUsercategories();

      // Merge both lists
      categories = [...?defaultCategories, ...?usercategories];

      print("All categories: $categories");
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

//feach todos based on category
  Future<void> fetchCatgoryTodos(String category) async {
    isLoading = true;
    notifyListeners();
    try {
      final fetchedCategoryTodos = await _todoRepo
          .getCategoryTodos(category); // Replace with your actual fetch logic
      categorytodos = fetchedCategoryTodos;
    } catch (e) {
      print("Error fetching todos: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<String> addnewcategory(String newcategory) async {
    String formatedcategory = newcategory.toLowerCase();
    try {
      if (categories!.any((cat) => cat.toLowerCase() == formatedcategory)) {
        print('category already exist');
        return 'Category already exist';
      }
      await _todoRepo.addnewcategory(newcategory);
      loadAllCategories();
      notifyListeners();
      return 'Category added sussessfully!';
    } catch (e) {
      print(e);
      print("error in category adding");
      return 'Error in adding category';
    }
  }
}
