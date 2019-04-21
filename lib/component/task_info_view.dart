import 'package:flutter/material.dart';
import '../model/task.dart';

class TaskInfoView extends StatelessWidget {
  final Task task;

  TaskInfoView({@required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Hero(
        tag: task.id,
        child: Container(
          color: task.color,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 48),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(
                task.name,
                style: Theme.of(context).textTheme.title,
              ),
            )
          ],
        ),
      ),
    ]));
  }
}
