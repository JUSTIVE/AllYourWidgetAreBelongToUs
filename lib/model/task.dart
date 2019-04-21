import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Task {
  int id;
  String name;
  bool isDone;
  Color color;
  DateTime doneTime;
  DateTime goalTime;
  bool shouldNotify;

  Task(
      {@required this.id,
      @required this.name,
      this.isDone = false,
      this.color,
      this.goalTime,
      this.shouldNotify
      }):this.doneTime=DateTime.now();

  Task.map(dynamic obj) {
    this.id = int.parse(obj['id']);
    this.name = obj['name'].toString();
    this.isDone = obj['isDone'];
    this.color = hexToColor(obj['color']);
  }

  Task.fromSnapshot(DataSnapshot snapshot) {
    this.id = int.tryParse(snapshot.key);
    this.name = snapshot.value['name'];
    this.isDone = snapshot.value['isDone'];
    this.color = hexToColor(snapshot.value['color']);
  }
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
