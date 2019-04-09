import 'package:meta/meta.dart';
import 'dart:ui';
import '../model/task.dart';
import 'package:bloc/bloc.dart';

abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String name;
  final Color color;
  AddTaskEvent({@required this.name,@required this.color});
}

class DoneTaskEvent extends TaskEvent {
  final int id;
  DoneTaskEvent({@required this.id});
}

class TaskBloc extends Bloc<TaskEvent, List<Task>> {
  static int counter = 0;
  @override
  List<Task> get initialState => [];

  @override
  Stream<List<Task>> mapEventToState(event)async* {
    switch (event.runtimeType) {
      case AddTaskEvent:
        currentState.add(Task(id: counter++, name: (event as AddTaskEvent).name));
        break;
      case DoneTaskEvent:
        break;
    }
  }
}
