import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/task_bloc.dart';
import 'component/color_radio_widget.dart';

class TaskAddScreen extends StatefulWidget {
  @override
  _TaskAddScreenState createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  TextEditingController _textEditingController;
  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(children: [
        Hero(
          tag: "addingHero",
          child: Material(
            color: Colors.greenAccent,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 48),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "New Task",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.white),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_textEditingController.text.trim() != "") {
                          BlocProvider.of<TaskBloc>(context).dispatch(
                              AddTaskEvent(
                                  name: _textEditingController.text,
                                  color: ColorRadio
                                      .colorTable[ColorRadio.currentColorId]));
                          Navigator.pop(context);
                        } else {
                          (_scaffoldKey.currentState as ScaffoldState)
                              .showSnackBar(SnackBar(
                            content: Text("이름을 붙여주세요"),
                          ));
                        }
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 48,
              ),
              TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: "이름",
                    labelStyle: TextStyle(fontSize: 24, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  cursorColor: Colors.white,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 32,
              ),
              Container(height: 52, child: ColorRadio())
            ],
          ),
        )
      ]),
    );
  }
}
