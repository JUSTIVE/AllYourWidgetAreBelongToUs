import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.dart';
import 'bloc/task_bloc.dart';

void main() => runApp(MyApp());

// This widget is the root of your application.
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  final TaskBloc _taskBloc = TaskBloc();

  @override
  Widget build(BuildContext context) {
    // set material design app
    return BlocProviderTree(
      blocProviders: <BlocProvider>[
        BlocProvider<TaskBloc>(
          bloc: _taskBloc,
        )
      ],
      child: BlocBuilder(
        bloc: _taskBloc,
        builder: (_, taskbloc) => MaterialApp(
          debugShowCheckedModeBanner: false,
            title: 'solocoding2019', // application name
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(
                title: TextStyle(
                  fontSize: 42,
                  color: Colors.black87,
                  fontWeight: FontWeight.w900
                )
              )
            ),
            home: HomeWidget()),
      ),
    );
  }

  @override
  void dispose() {
    _taskBloc.dispose();
    super.dispose();
  }
}
