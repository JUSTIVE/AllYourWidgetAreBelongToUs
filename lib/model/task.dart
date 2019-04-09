import 'package:flutter/material.dart';
import 'dart:math';

class Task {
  int id;
  String name;
  bool isDone;
  Color color;

  static List<Color> colorTable = [Colors.blue.shade300,Colors.red.shade300,Colors.amber.shade300];

  Task({@required this.id,@required this.name,this.isDone=false}):color=colorTable[Random().nextInt(colorTable.length-1)];
}
