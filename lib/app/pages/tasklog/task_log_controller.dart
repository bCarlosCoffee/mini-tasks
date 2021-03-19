import 'package:todo_list/app/getx/task_log_getx.dart';

class TaskLogController {
  final TaskLogGetx stateManager;

  TaskLogController(this.stateManager);

  bool get isLoading => stateManager.isLoading;
  bool get editing => stateManager.taskToEdit != null;
  String get taskName => stateManager.taskName;
  String get taskDescription => stateManager.taskDescription;
  String get taskPriority => stateManager.taskPriority;
  DateTime get dateToPerformTask => stateManager.dateToPerformTask;
  DateTime get dueDateOfTheTask => stateManager.dueDateOfTheTask;

  String formatDate(DateTime datetime) {
    return '${datetime.day}/${datetime.month}/${datetime.year} às ${datetime.hour}:${datetime.minute}';
  }

  saveTask() => stateManager.saveTask();

  updateTask() => stateManager.updateTask();

  deleteTask() => stateManager.deleteTask();
}
