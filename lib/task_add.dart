import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'bloc/task_bloc.dart';
import 'component/color_radio_widget.dart';

class TaskAddScreen extends StatefulWidget {
  @override
  _TaskAddScreenState createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  TextEditingController _textEditingController;
  
  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final _colorRadioKey = GlobalKey<ColorRadioState>();
  bool isDateUpdated = false;
  DateTime goalDateTime = DateTime.now();

  @override
  void initState() {
    _textEditingController = TextEditingController();
    goalDateTime=DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: ListView(
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
                          print(ColorRadio.colorTable[
                              _colorRadioKey.currentState.currentColorId]);
                          BlocProvider.of<TaskBloc>(context).dispatch(
                              AddTaskEvent(
                                  name: _textEditingController.text,
                                  color: ColorRadio.colorTable[_colorRadioKey
                                      .currentState.currentColorId],
                                  shouldNotify: isDateUpdated,
                                  goalTime: goalDateTime));
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
              Text(
                "Colors",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(height: 52, child: ColorRadio(key: _colorRadioKey)),
              SizedBox(
                height: 32,
              ),
              Text(
                "Remind",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              DateTimePickerFormField(
                initialValue: DateTime.now(),
                inputType: InputType.both,
                format: DateFormat('yyyy-MM-dd hh:mm:ss'),
                editable: true,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                resetIcon: Icons.close,
                decoration: InputDecoration(
                  labelText: "시간",
                  labelStyle: TextStyle(fontSize: 24, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.white)),
                ),
                onChanged: (dt) => setState(() {
                      goalDateTime = dt;
                      isDateUpdated = true;
                    }),
              )
            ],
          ),
        )
      ]),
    );
  }
}
