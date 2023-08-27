
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/to_do_cubit.dart';
import '../../constants/size_config.dart';
import '../widgets/todo_view.dart';
import 'add_todo.dart';

// ignore: must_be_immutable
class ToDoList extends StatelessWidget {
  ToDoList({super.key});

  static const String id = '/todo_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddTodo.id);
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,

        elevation: .8,
        title: Text(
          'To Do',
          style: TextStyle(
            fontSize: 20.0 * SizeConfig.textRatio,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ToDoSuccessState) {
            return RefreshIndicator(
              onRefresh: () async {
                ToDoCubit.get(context).fetchToDoData();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0 * SizeConfig.horizontalBlock,
                  vertical: 10 * SizeConfig.verticalBlock,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated (
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.unCompletedTasks.length,
                        itemBuilder: (context, index) {
                          return TodoView(
                            todo: state.unCompletedTasks[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 5 * SizeConfig.verticalBlock,
                          );
                        },
                      ),
                      SizedBox(
                        height: 5 * SizeConfig.verticalBlock,
                      ),
                      Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 20.0 * SizeConfig.textRatio,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5 * SizeConfig.verticalBlock,
                      ),
                      ListView.separated (
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.completedTasks.length,
                        itemBuilder: (context, index) {
                          return TodoView( todo: state.completedTasks[index],);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 5 * SizeConfig.verticalBlock,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if(state is  ToDoErrorState){
            return Center(child: Text(state.errorMessage,));
          }
          if(state is TodoUpdateSuccessState|| state is TodoDeleteSuccessState|| state is TodoAddSuccessState){
            ToDoCubit.get(context).fetchToDoData();
          }
          return Center(child: CircularProgressIndicator());

        },
      ),
    );
  }


}
