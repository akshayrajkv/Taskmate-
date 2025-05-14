
import 'package:flutter/material.dart';
import 'package:task_mate2/features/todo_screen/model/todomodel.dart';
import 'package:task_mate2/features/todo_screen/model/userdetailmodel.dart';
import 'package:task_mate2/features/todo_screen/services/todo_servises.dart';

class Todorepo{
final TodoServises _todoServises =TodoServises();


// to get the user details
Future<Usermodel?>getUser()async{
  return await _todoServises.userdetail();
}
//update userimage

Future<void>updateuser(String profileImage)async{
    return await _todoServises.updateuserdetails(profileImage);
  }
//to get the Todos
  Future<List<Todoclass>?>getTodos()async{
    
  return await  _todoServises.fetchTodos();
  }

  //to create a new todo

  Future<bool>createTodo(Todoclass todo)async{
    return await _todoServises.createTodo(todo);
  }

//to update a todo

Future<bool>updateTodo(String taskid, Todoclass todo)async{
  return await _todoServises.updateTodo(taskid, todo);
  
}
// to delete a todo 

Future<void>deleteTodo(String taskid)async{
  return await _todoServises.deleteTodo(taskid);
}
//to get all categories

  Future<List<String>?>getallcategories()async{
  return await _todoServises.getAllcategory();
  }

// to get user categories

 Future<List<String>?>getUsercategories()async{
  return await _todoServises.getUsercategory();
  }

// to get todo based on the category

  Future<List<Todoclass>?>getCategoryTodos(String category)async{
    
  return await  _todoServises.fetchcategorytodos(category);
  }
// to add new category for user

  Future <void>addnewcategory(String newcategory)async{
    return await _todoServises.addnewcategory(newcategory);
  }


}