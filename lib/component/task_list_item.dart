import 'package:flutter/material.dart';
import '../model/task.dart';
import 'package:share/share.dart';

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
      onDismissed: (direction) {
        setState(() {
          switch (direction) {
            case DismissDirection.startToEnd:
              widget.task.isDone = true;
              break;
            case DismissDirection.endToStart:
              break;
            default:
              break;
          }
        });
      },
      child: Material(
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
                icon: Icon(Icons.share,color: Colors.black.withOpacity(0.56)),
                onPressed: () {
                  Share.share('www.justie.me');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
