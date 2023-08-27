import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../business_logic/cubit/to_do_cubit.dart';
import '../../constants/size_config.dart';
import '../../models/entities/todo_model.dart';
import '../widgets/AwesomeDialog.dart';

class AddTodo extends StatelessWidget {
 static final TextEditingController titleController = TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  static const String id = 'todo_add';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        elevation: .8,
        title: Text(
          'New To Do',
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
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        AwesomeDialogShow.showAwesomeDialog(
                          context,
                          title: "Are you sure you want to save this todo?",
                          btnCancelColor: Colors.red,
                          btnCancel: true,
                          btnOk: true,
                          btnOkColor: Colors.green,
                          dialogType: DialogType.WARNING,

                          buttonCancelOnTap: () {
                            Navigator.pop(context);
                          },
                          buttonOkOnTap: () async{

                           await ToDoCubit.get(context).addTodo( titleController.text);
                            titleController.clear();

                            Navigator.pop(context);
                          },
                        );


                      },
                      child: Text(
                        'Add',
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
                        Navigator.pop(context);

                      },

                      child: Text(
                        'Cancel',
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
