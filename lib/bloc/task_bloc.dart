import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import '../model/task.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class TaskEvent {}

class InitialTaskEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String name;
  final Color color;
  final bool shouldNotify;
  final DateTime goalTime;
  AddTaskEvent(
      {@required this.name,
      @required this.color,
      @required this.shouldNotify,
      @required this.goalTime});
}

class DoneTaskEvent extends TaskEvent {
  final int id;
  final DateTime doneTime;
  DoneTaskEvent({@required this.id, @required this.doneTime});
}

class DeleteTaskEvent extends TaskEvent {
  final int id;
  DeleteTaskEvent({@required this.id});
}

class TaskBloc extends Bloc<TaskEvent, List<Task>> {
  static int counter = 0;
  @override
  List<Task> get initialState => [];

  @override
  Stream<List<Task>> mapEventToState(event) async* {
    switch (event.runtimeType) {
      case InitialTaskEvent:
        // final
        break;
      case AddTaskEvent:
        currentState.add(Task(
            id: counter++,
            name: (event as AddTaskEvent).name,
            color: (event as AddTaskEvent).color,
            shouldNotify: (event as AddTaskEvent).shouldNotify,
            goalTime: (event as AddTaskEvent).goalTime));
        break;
      case DoneTaskEvent:
        var item =
            currentState.firstWhere((x) => x.id == (event as DoneTaskEvent).id);
        item.isDone = true;
        item.doneTime = (event as DoneTaskEvent).doneTime;
        currentState.sort((task1, task2) => task1.id.compareTo(task2.id));
        break;
      case DeleteTaskEvent:
        currentState.removeWhere((x) => x.id == (event as DeleteTaskEvent).id);
        break;
    }
  }
}
