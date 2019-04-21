import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'task_add.dart';

import 'model/task.dart';
import 'bloc/task_bloc.dart';
import 'component/task_list_item.dart';
import 'component/task_list_item_done.dart';
import 'component/task_list_item_archive.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  void repaint() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final TaskBloc _taskBloc = BlocProvider.of<TaskBloc>(context);
    final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        body: Padding(
          padding: EdgeInsets.only(top: 48),
          child: Stack(children: [
            BlocBuilder(
              bloc: _taskBloc,
              builder: (context, bloc) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 32),
                      child: Text(
                        "TODO",
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    SizedBox(height: 12),
                    (bloc as List<Task>).where((x) => !x.isDone&&!x.isArchived).isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(left: 32),
                            child: Text("오늘 할일을 다 끝냈어요"))
                        : ListView.builder(
                            itemCount: (bloc as List<Task>)
                                .where((x) => !x.isDone && !x.isArchived)
                                .length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => TaskListItem(
                                  task: (bloc as List<Task>)
                                      .where((x) => !x.isDone && !x.isArchived)
                                      .toList()[index],
                                  repaint: repaint,
                                  parentScaffold: _scaffoldKey,
                                ),
                          ),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                  onTap: () {
                    (_scaffoldKey.currentState as ScaffoldState)
                        .showBottomSheet((context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: BottomSheet(
                          builder: (context) => Material(
                                elevation: 4,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    topRight: Radius.circular(32)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  height:
                                      MediaQuery.of(context).size.height - 32,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(32),
                                          topRight: Radius.circular(32)),
                                      color: Colors.blue),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 64,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 24),
                                        child: Text(
                                          "ARCHIVE",
                                          style: Theme.of(context)
                                              .textTheme
                                              .title
                                              .copyWith(
                                                  color: Colors.white
                                                      .withOpacity(0.89)),
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          BlocBuilder(
                                            bloc: _taskBloc,
                                            builder: (context, bloc) => (bloc
                                                            as List<Task>)
                                                        .where(
                                                            (x) => x.isArchived)
                                                        .length >
                                                    0
                                                ? ListView.builder(
                                                    itemCount: (bloc
                                                            as List<Task>)
                                                        .where(
                                                            (x) => x.isArchived)
                                                        .length,
                                                    shrinkWrap: true,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        TaskListItemArchive(
                                                          task: ((bloc
                                                                  as List<Task>)
                                                              .where((x) =>
                                                                  x.isArchived)
                                                              .toList())[index],
                                                          parentScaffold:
                                                              _scaffoldKey,
                                                          repaint: repaint,
                                                        ))
                                                : Container(),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white
                                                    .withOpacity(0.89),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          onClosing: () {},
                        ),
                      );
                    });
                  },
                  child: Container(
                    height: 96,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32)),
                        color: Colors.blue),
                    child: Transform.translate(
                      offset: Offset(24, -20),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.archive,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("ARCHIVE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                  onTap: () {
                    (_scaffoldKey.currentState as ScaffoldState)
                        .showBottomSheet((context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: BottomSheet(
                          builder: (context) => Material(
                                elevation: 4,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    topRight: Radius.circular(32)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  height:
                                      MediaQuery.of(context).size.height - 32,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(32),
                                          topRight: Radius.circular(32)),
                                      color: Colors.amber),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 64,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 24),
                                        child: Text(
                                          "DONE",
                                          style: Theme.of(context)
                                              .textTheme
                                              .title
                                              .copyWith(
                                                  color: Colors.white
                                                      .withOpacity(0.89)),
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          BlocBuilder(
                                            bloc: _taskBloc,
                                            builder: (context, bloc) => (bloc
                                                            as List<Task>)
                                                        .where((x) => x.isDone)
                                                        .length >
                                                    0
                                                ? ListView.builder(
                                                    itemCount: (bloc
                                                            as List<Task>)
                                                        .where((x) => x.isDone)
                                                        .length,
                                                    shrinkWrap: true,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        TaskListItemDone(
                                                            task: ((bloc
                                                                    as List<Task>)
                                                                .where((x) => x.isDone)
                                                                .toList())[index]))
                                                : Container(),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white
                                                    .withOpacity(0.89),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          onClosing: () {},
                        ),
                      );
                    });
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32)),
                        color: Colors.amber),
                    child: Transform.translate(
                      offset: Offset(24, 0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("DONE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 225),
              child: Align(
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
            ),
          ]),
        ));
  }
}
