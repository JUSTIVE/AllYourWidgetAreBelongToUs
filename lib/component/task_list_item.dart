import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/task.dart';
import 'package:share/share.dart';
import '../bloc/task_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskListItem extends StatefulWidget {
  final Task task;
  final VoidCallback repaint;
  TaskListItem({@required this.task,@required this.repaint});
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
      ),
    );
  }
}
