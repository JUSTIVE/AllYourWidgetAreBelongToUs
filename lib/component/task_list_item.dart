import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/task.dart';
import 'package:share/share.dart';
import '../bloc/task_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskListItem extends StatefulWidget {
  final Task task;
  final VoidCallback repaint;
  final GlobalKey<ScaffoldState> parentScaffold;
  TaskListItem({@required this.task,@required this.repaint, @required this.parentScaffold});
  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  GlobalKey key = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TaskBloc _taskBloc = BlocProvider.of<TaskBloc>(context);

    return Slidable(
      key: Key(widget.task.id.toString() + widget.task.isDone.toString()),
      delegate: SlidableScrollDelegate(),
      actions: <Widget>[
        IconSlideAction(
          icon: Icons.delete,
          color: Colors.red.shade300,
          caption: "delete",
          onTap: () {
            _taskBloc.dispatch(DeleteTaskEvent(id: widget.task.id));
            widget.repaint();
            widget.parentScaffold.currentState.showSnackBar(SnackBar(
              content: Text(widget.task.name+" has been deleted"),
            ));
          },
        )
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          icon: Icons.check,
          caption: "done",
          onTap: () {
            _taskBloc.dispatch(
                DoneTaskEvent(id: widget.task.id, doneTime: DateTime.now()));
            widget.repaint();
            widget.parentScaffold.currentState.showSnackBar(SnackBar(
              content: Text(widget.task.name+" has been done"),
            ));
          },
        ),
        IconSlideAction(
          color: Colors.blue,
          icon: Icons.archive,
          caption: "archive",
          onTap: () {
            _taskBloc.dispatch(
                ArchiveTaskEvent(id: widget.task.id));
            widget.repaint();
            widget.parentScaffold.currentState.showSnackBar(SnackBar(
              content: Text(widget.task.name+" has been archived"),
            ));
          },
        )
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
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
                      style: Theme.of(context).textTheme.body1,
                    ),
                    widget.task.shouldNotify?
                    Text(
                      widget.task.goalTime.toUtc().year.toString() +
                        "." +
                        widget.task.goalTime.toUtc().month.toString() +
                        "." +
                        widget.task.goalTime.toUtc().day.toString() +
                        " " +
                        widget.task.goalTime.toUtc().hour.toString() +
                        ":" +
                        widget.task.goalTime.toUtc().minute.toString() +
                        ":" +
                        widget.task.goalTime.toUtc().second.toString(),
                        style: TextStyle(fontSize: 10),
                    ):Container()
                  ],
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
      ),
    );
  }
}
