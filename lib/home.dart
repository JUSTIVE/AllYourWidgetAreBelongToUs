import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/task_bloc.dart';
import 'model/Task.dart';
import 'component/task_list_item.dart';
import 'dart:math';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    final TaskBloc _taskBloc = BlocProvider.of<TaskBloc>(context);

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Stack(children: [
        BlocBuilder(
          bloc: _taskBloc,
          builder: (context, bloc) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Text(
                      "TODOs",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  ListView(
                    children: <Widget>[
                      Column(
                        children: (bloc as List<Task>)
                            .where((x) => x.isDone != true)
                            .map((x) => TaskListItem())
                            .toList(),
                      )
                    ],
                  )
                ],
              ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Transform.rotate(
              child: Material(
                elevation: 12,
                shadowColor: Colors.greenAccent.shade200,
                borderRadius: BorderRadius.circular(16),
                color: Colors.greenAccent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
                  child: Padding(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(16),
                  ),
                ),
              ),
              angle: 45 * pi / 60),
        ),
      ]),
    ));
  }
}
