

import 'package:flutter/material.dart';

import '../presentation/screens/add_todo.dart';
import '../presentation/screens/todo_details.dart';
import '../presentation/screens/todo_list.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> appRoutes = {
    ToDoList.id: (context) =>  ToDoList(),
    TodoDetails.id: (context) =>  TodoDetails(),
    AddTodo.id: (context) =>  AddTodo(),




  };
}
