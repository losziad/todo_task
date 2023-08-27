
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../constants/end_point.dart';
import '../entities/todo_model.dart';
import '../network_services.dart';
class NotesLogic{
 static final NetworkServices networkServices=NetworkServices();
  static Future getNotes()async {
    try{
      const url = BASE_URL+ EndPointGetAndPost;
      final response = await networkServices.makeRequest(url,method: 'GET');
      final List<dynamic> jsonResponse = json.decode(response.body);
      List <ToDoModel> tasks = [];
      jsonResponse.forEach((element) {
        tasks.add(ToDoModel.fromJson(element));
      });
      return tasks;
    }catch(error){
      rethrow;
    }


  }

  static deleteNotes( int id) async{
    try{
      final url = BASE_URL+ EndPointGetAndPost+'/$id';
      final body = {
        "id": id,
      };
      await networkServices.makeRequest(url,method: 'DELETE',body: body);
    }catch(error){
      rethrow;
    }

  }

  static updateNotes(ToDoModel toDoModel)async {
    try{
      final url = BASE_URL+ EndPointGetAndPost+'/${toDoModel.id}';
      final body = {
        "title": toDoModel.title,
        "completed": toDoModel.completed,
      };
      await networkServices.makeRequest(url,method: 'PUT',body: body);
    }catch(error){
      rethrow;
    }

  }

  static addNotes(String text)async {
    try{
      final url = BASE_URL+ EndPointGetAndPost;
      print(text);
      final body = {
        "title": text,
      };
      await networkServices.makeRequest(url,method: 'POST',body: body);
    }catch(error){
      rethrow;
    }
  }
}
