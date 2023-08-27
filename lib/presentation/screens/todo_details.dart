import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../business_logic/cubit/to_do_cubit.dart';
import '../../constants/size_config.dart';
import '../../models/entities/todo_model.dart';
import '../widgets/AwesomeDialog.dart';

class TodoDetails extends StatelessWidget {
 static ToDoModel? content;
  static final TextEditingController titleController = TextEditingController(text:content!.title! );

 static final  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TodoDetails({ToDoModel? todo}) {
    content = todo;
  }


  static const String id = 'todo_details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        elevation: .8,
        title: Text(
          'To Do Details',
          style: TextStyle(
            fontSize: 20.0 * SizeConfig.textRatio,

            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16*SizeConfig.horizontalBlock,vertical: 10*SizeConfig.verticalBlock),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(fontSize: 18*SizeConfig.textRatio,),

                  minLines: 1,
                  maxLines: 15,

controller: titleController,
                  onTapOutside: (tap) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onFieldSubmitted: (value) {
                    formKey.currentState!.save();
                  },
                  decoration: InputDecoration(

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                ),
                SizedBox(
                  height: 30*SizeConfig.verticalBlock,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        AwesomeDialogShow.showAwesomeDialog(
                          context,
                          title: "Are you sure you want to update this todo?",
                          btnCancelColor: Colors.blue,
                          btnCancel: true,
                          btnOk: true,
                          btnOkColor: Colors.red,
                          dialogType: DialogType.WARNING,

                          buttonCancelOnTap: () {
                            Navigator.pop(context);
                          },
                          buttonOkOnTap: () {
                            content!.title=titleController.text;
                            ToDoCubit.get(context).updateTodo(content!);
                            titleController.clear();
                            Navigator.pop(context);
                          },
                        );


                      },
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 20.0 * SizeConfig.textRatio,

                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      color: Colors.blue,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    MaterialButton(

                        onPressed: () {
                          AwesomeDialogShow.showAwesomeDialog(
                            context,
                            title: "Are you sure you want to delete this todo?",
btnCancelColor: Colors.blue,
                            btnCancel: true,
                            btnOk: true,
                            btnOkColor: Colors.red,
                            dialogType: DialogType.WARNING,

                            buttonCancelOnTap: () {
                              Navigator.pop(context);
                            },
                            buttonOkOnTap: () {
                              ToDoCubit.get(context).deleteTodo(content!.id!);
                              Navigator.pop(context);
                            },
                          );

                        },

                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 20.0 * SizeConfig.textRatio,

                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      color: Colors.red,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
