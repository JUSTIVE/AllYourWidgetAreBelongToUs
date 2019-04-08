import '../model/Task.dart';
import 'package:bloc/bloc.dart';

abstract class TaskEvent {
  final int id;
  TaskEvent({this.id});
}

class AddTaskEvent extends TaskEvent {
  final String name;
  AddTaskEvent({id, this.name}) : super(id: id);
}

class DoneTaskEvent extends TaskEvent {
  DoneTaskEvent({id}) : super(id: id);
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
