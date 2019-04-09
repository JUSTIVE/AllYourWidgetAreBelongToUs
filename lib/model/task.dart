import 'package:flutter/material.dart';

class Task {
  int id;
  String name;
  bool isDone;

  Task({@required this.id,@required this.name,this.isDone=false});
}
