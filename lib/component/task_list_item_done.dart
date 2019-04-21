import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/task.dart';
import 'package:share/share.dart';
import '../bloc/task_bloc.dart';

class TaskListItemDone extends StatefulWidget {
  final Task task;
  TaskListItemDone({@required this.task});
  @override
  _TaskListItemDoneState createState() => _TaskListItemDoneState();
}

class _TaskListItemDoneState extends State<TaskListItemDone> {
  GlobalKey key = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TaskBloc _taskBloc = BlocProvider.of<TaskBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.task.isDone ? 16 : 32),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: widget.task.color),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.task.name,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Colors.white.withOpacity(0.89)),
                  ),
                  Text(
                    widget.task.doneTime.toUtc().year.toString() +
                        "." +
                        widget.task.doneTime.toUtc().month.toString() +
                        "." +
                        widget.task.doneTime.toUtc().day.toString() +
                        " " +
                        widget.task.doneTime.toUtc().hour.toString() +
                        ":" +
                        widget.task.doneTime.toUtc().minute.toString() +
                        ":" +
                        widget.task.doneTime.toUtc().second.toString(),
                    style: TextStyle(
                        fontSize: 10, color: Colors.white.withOpacity(0.89)),
                  )
                ],
              ),
              Expanded(
                child: Container(),
              ),
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.white.withOpacity(0.89),
                  size: 18,
                ),
                onPressed: () {
                  Share.share('${widget.task.name}');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
