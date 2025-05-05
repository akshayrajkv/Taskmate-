
import 'package:flutter/material.dart';
import 'package:task_mate2/features/todo_screen/model/todomodel.dart';
import 'package:task_mate2/features/todo_screen/model/userdetailmodel.dart';
import 'package:task_mate2/features/todo_screen/services/todo_servises.dart';

class Todorepo{
final TodoServises _todoServises =TodoServises();

Future<Usermodel?>getUser()async{
  return await _todoServises.userdetail();
}
  

  Future<List<Todoclass>?>getTodos()async{
    
  return await  _todoServises.fetchTodos();
  }

  Future<bool>createTodo(Todoclass todo)async{
    return await _todoServises.createTodo(todo);


  }
  Future<List<String>?>getallcategories()async{
  return await _todoServises.getAllcategory();
  }

 Future<List<String>?>getUsercategories()async{
  return await _todoServises.getUsercategory();
  }


  Future<List<Todoclass>?>getCategoryTodos(String category)async{
    
  return await  _todoServises.fetchcategorytodos(category);
  }

  Future <void>addnewcategory(String newcategory)async{
    return await _todoServises.addnewcategory(newcategory);
  }


}