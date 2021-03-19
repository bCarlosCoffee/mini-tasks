import 'package:todo_list/app/getx/task_history_getx.dart';
import 'package:todo_list/app/models/task_model.dart';

class TaskHistoryController {
  final TaskHistoryGetx _stateManager;

  TaskHistoryController(this._stateManager);

  bool get isLoading => _stateManager.isLoading;
  List<TaskModel> get tasks => _stateManager.tasks;
}
