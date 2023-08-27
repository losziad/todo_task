import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_task/constants/end_point.dart';
import 'package:http/http.dart' as http;

import '../../models/entities/todo_model.dart';
import '../../models/model_logic/notes_logic.dart';
part 'to_do_state.dart';

class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() : super(ToDoInitialState());

  static ToDoCubit get(context) => BlocProvider.of(context);

   List<ToDoModel> tasks = [];

  ToDoModel? toDoModel;


  Future<void> fetchToDoData()async{
    try {
      emit(ToDoLoadingState());
      tasks = await NotesLogic.getNotes();
      List <ToDoModel> unCompletedTasks = tasks.where((element) => element.completed == false).toList();
      List <ToDoModel> completedTasks = tasks.where((element) => element.completed == true).toList();
      emit(ToDoSuccessState(unCompletedTasks,completedTasks));
    } catch (exception) {
      emit(ToDoErrorState(exception.toString()));
    }
  }
  Future<void> deleteTodo(int id) async {
    try {
      emit(ToDoLoadingState());
      await NotesLogic.deleteNotes(id);

      emit(TodoDeleteSuccessState());
    } catch (exception) {
      emit(ToDoErrorState(exception.toString()));
    }
  }



  Future<void> updateTodo( ToDoModel toDoModel) async{
    try {
      emit(ToDoLoadingState());
      await NotesLogic.updateNotes(toDoModel);
      emit(TodoUpdateSuccessState());
    } catch (exception) {
      emit(ToDoErrorState(exception.toString()));
    }
  }

  Future<void> addTodo(String text) async{
    try {
      emit(ToDoLoadingState());

      await NotesLogic.addNotes(text);
      emit(TodoAddSuccessState());
    } catch (exception) {
      emit(ToDoErrorState(exception.toString()));
    }
  }


}
