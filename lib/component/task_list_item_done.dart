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
                    shape: BoxShape.circle,
                    color: widget.task.isDone
                        ? Colors.grey.shade100
                        : widget.task.color),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                widget.task.name,
                style: Theme.of(context).textTheme.body1,
              ),
              Expanded(
                child: Container(),
              ),
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.black.withOpacity(0.56),
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
