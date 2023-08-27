part of 'to_do_cubit.dart';

@immutable
abstract class ToDoStates {}

class ToDoInitialState extends ToDoStates {}

class ToDoLoadingState extends ToDoStates{}

class ToDoSuccessState extends ToDoStates{
  final List<ToDoModel> unCompletedTasks;
  final List<ToDoModel> completedTasks;

  ToDoSuccessState(this.unCompletedTasks,this.completedTasks);
}


class ToDoErrorState extends ToDoStates{
  final String errorMessage;

  ToDoErrorState(this.errorMessage);
}
class TodoAddSuccessState extends ToDoStates{}
class TodoDeleteSuccessState extends ToDoStates{}
class TodoUpdateSuccessState extends ToDoStates{}
