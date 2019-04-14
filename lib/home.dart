import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'task_add.dart';

import 'model/task.dart';
import 'bloc/task_bloc.dart';
import 'component/task_list_item.dart';

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
                  (bloc as List<Task>).where((x) => x.isDone != true).length ==
                          0
                      ? Padding(
                          padding: EdgeInsets.only(left: 32),
                          child: Text("할일이 없어요"))
                      : ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            Padding(
                              child: Column(
                                children: (bloc as List<Task>)
                                    .where((x) => x.isDone != true)
                                    .map((x) => TaskListItem(task: x))
                                    .toList(),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 32),
                            )
                          ],
                        ),
                  SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Text("done"),
                  ),
                  SizedBox(height: 16),
                  ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Padding(
                        child: Column(
                          children: (bloc as List<Task>)
                              .where((x) => x.isDone == true)
                              .map((x) => TaskListItem(task: x))
                              .toList(),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      )
                    ],
                  ),
                ],
              ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Transform.rotate(
              child: Hero(
                tag: "addingHero",
                child: Material(
                  elevation: 12,
                  shadowColor: Colors.greenAccent.shade200,
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.greenAccent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskAddScreen()));
                    },
                    child: Padding(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(16),
                    ),
                  ),
                ),
              ),
              angle: 45 * pi / 60),
        ),
      ]),
    ));
  }
}
