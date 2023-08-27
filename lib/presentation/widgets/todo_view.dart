import 'package:flutter/material.dart';

import '../../business_logic/cubit/to_do_cubit.dart';
import '../../constants/size_config.dart';
import '../../models/entities/todo_model.dart';
import '../screens/todo_details.dart';

class TodoView extends StatelessWidget {
  ToDoModel todo;

  TodoView({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16*SizeConfig.horizontalBlock,
        vertical: 10*SizeConfig.verticalBlock
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10*SizeConfig.horizontalBlock),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),

      ),
      height: 100* SizeConfig.verticalBlock,
      child: Row(
        children: [
          Transform.scale(
            scale: 1.5,
            child: Checkbox(

              checkColor: Colors.white,
              value: todo.completed,
              visualDensity: VisualDensity.adaptivePlatformDensity, // Adjusts the padding around the checkbox

              onChanged: (c){
                todo.completed=c!;
                ToDoCubit.get(context).updateTodo(todo);

              },

            ),
          ),
          Expanded(
            child: Text(todo.title!,
              style: TextStyle(fontSize: 18*SizeConfig.textRatio,)
              ,overflow: TextOverflow.ellipsis,maxLines: 2,
            ),
          ),



          Padding(
            padding:  EdgeInsets.only(left: 8*SizeConfig.horizontalBlock),
            child: ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TodoDetails(
                todo: todo,

              )));
            }, child: Text("Details")),
          )
        ],
      ),
    );
  }
}
