import 'package:flutter/material.dart';

class Task {
  int id;
  String name;
  bool isDone;
  Color color;

  

  Task({@required this.id,@required this.name,this.isDone=false, this.color});
}
