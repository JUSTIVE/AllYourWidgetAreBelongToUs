import 'package:flutter/material.dart';
import 'bloc/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskAddScreen extends StatefulWidget {
  @override
  _TaskAddScreenState createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    return Scaffold(
      body: Container(
        child: Hero(
          tag: "addingHero",
          child: Material(
            color: Colors.greenAccent,
          ),
        ),
      ),
    );
  }
}
