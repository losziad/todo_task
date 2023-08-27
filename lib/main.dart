import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/business_logic/cubit/to_do_cubit.dart';
import 'package:todo_task/constants/size_config.dart';
import 'package:todo_task/presentation/screens/todo_list.dart';

import 'constants/Routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
       BlocProvider(
           create: (context) => ToDoCubit()..fetchToDoData(),
       ),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes:AppRoutes.appRoutes,
      theme: ThemeData(
        brightness: Brightness.dark,

        useMaterial3: true,
      ),
      initialRoute: ToDoList.id,
    ),);
  }
}

/*
*  appBar: AppBar(
              backgroundColor: Colors.black54,
              elevation: .8,
              title: Text(
                'To DO',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),*/