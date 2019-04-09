import 'package:flutter/material.dart';
import '../model/task.dart';

class TaskListItem extends StatefulWidget {
  final Task task;
  TaskListItem({@required this.task});
  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.task.id.toString()),
      child: Material(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              Text(
                widget.task.name,
                style: Theme.of(context).textTheme.body1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
