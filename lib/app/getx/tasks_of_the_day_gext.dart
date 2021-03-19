import 'package:get/get.dart';
import 'package:todo_list/app/models/response_model.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/services/interfaces/task_storage_service_interface.dart';
import 'package:todo_list/app/widgets/snackbar_widget.dart';

class TasksOfTheDayGext extends GetxController {
  final TaskStorageServiceInterface _service;

  TasksOfTheDayGext(this._service);

  Map<String, List<TaskModel>> _tasks = {
    'highPriority': [],
    'mediumPriority': [],
    'lowPriority': [],
    'completedTasks': [],
    'overdueTasks': [],
  };

  List<TaskModel> get tasks {
    return [
      ..._tasks['highPriority']!,
      ..._tasks['mediumPriority']!,
      ..._tasks['lowPriority']!,
      ..._tasks['completedTasks']!,
      ..._tasks['overdueTasks']!,
    ];
  }

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() async {
    _tasks['highPriority'] = [];
    _tasks['mediumPriority'] = [];
    _tasks['lowPriority'] = [];
    _tasks['completedTasks'] = [];
    _tasks['overdueTasks'] = [];

    final ResponseModel _responseModel =
        await _service.loadTasksOfTheDay(DateTime.now());

    if (_responseModel.error != null) {
      snackbarWidget(
        message: _responseModel.error!.message!,
        isError: true,
      );
    } else {
      _organizeTasks(tasksAux: _responseModel.result);
    }
    update();
  }

  void _organizeTasks({List<TaskModel>? tasksAux, String? priority}) {
    if (priority != null) {
      _tasks[priority]!.sort(
        (a, b) => a.taskCreationDate.isAfter(b.taskCreationDate) ? 1 : -1,
      );
    }

    tasksAux?.sort(
      (a, b) => a.taskCreationDate.isAfter(b.taskCreationDate) ? 1 : -1,
    );

    tasksAux?.forEach((TaskModel _taskModel) {
      addTask(_taskModel);
    });

    update();
  }

  void addTask(TaskModel _taskModel) {
    if (_taskModel.taskPriority == 'alta') {
      if (_taskModel.taskIsOverdue) {
        _tasks['overdueTasks']?.add(_taskModel);
      } else if (_taskModel.taskCompleted) {
        _tasks['completedTasks']?.add(_taskModel);
      } else {
        _tasks['highPriority']?.add(_taskModel);
      }
    } else if (_taskModel.taskPriority == 'média') {
      if (_taskModel.taskIsOverdue) {
        _tasks['overdueTasks']?.add(_taskModel);
      } else if (_taskModel.taskCompleted) {
        _tasks['completedTasks']?.add(_taskModel);
      } else {
        _tasks['mediumPriority']?.add(_taskModel);
      }
    } else if (_taskModel.taskPriority == 'baixa') {
      if (_taskModel.taskIsOverdue) {
        _tasks['overdueTasks']?.add(_taskModel);
      } else if (_taskModel.taskCompleted) {
        _tasks['completedTasks']?.add(_taskModel);
      } else {
        _tasks['lowPriority']?.add(_taskModel);
      }
    }
    _organizeTasks(priority: 'completedTasks');
  }

  Future markAsDone(int _taskIndex) async {
    final TaskModel _taskModel = tasks[_taskIndex];
    _taskModel.taskCompleted = !_taskModel.taskCompleted;

    if (_taskModel.taskCompleted) {
      if (_taskModel.taskPriority == 'alta') {
        _tasks['completedTasks']!.add(_taskModel);
        _tasks['highPriority']!.remove(_taskModel);
      } else if (_taskModel.taskPriority == 'média') {
        _tasks['completedTasks']!.add(_taskModel);
        _tasks['mediumPriority']!.remove(_taskModel);
      } else {
        _tasks['completedTasks']!.add(_taskModel);
        _tasks['lowPriority']!.remove(_taskModel);
      }
    } else {
      if (_taskModel.taskPriority == 'alta') {
        _tasks['highPriority']!.add(_taskModel);
        _tasks['completedTasks']!.remove(_taskModel);
      } else if (_taskModel.taskPriority == 'média') {
        _tasks['mediumPriority']!.add(_taskModel);
        _tasks['completedTasks']!.remove(_taskModel);
      } else {
        _tasks['lowPriority']!.add(_taskModel);
        _tasks['completedTasks']!.remove(_taskModel);
      }
    }

    final ResponseModel _responseModel = await _service.updateTask(_taskModel);

    if (_responseModel.error != null) {
      snackbarWidget(
        message: _responseModel.error!.message!,
        isError: true,
      );
    }

    update();
  }

  void removeTask(TaskModel? _taskModel) {
    if (_taskModel!.taskPriority == 'alta' &&
        !_taskModel.taskCompleted &&
        !_taskModel.taskIsOverdue) {
      _tasks['highPriority']!.remove(_taskModel);
    } else if (_taskModel.taskPriority == 'média' &&
        !_taskModel.taskCompleted &&
        !_taskModel.taskIsOverdue) {
      _tasks['mediumPriority']!.remove(_taskModel);
    } else if (_taskModel.taskPriority == 'baixa' &&
        !_taskModel.taskCompleted &&
        !_taskModel.taskIsOverdue) {
      _tasks['lowPriority']!.remove(_taskModel);
    } else {
      if (_taskModel.taskIsOverdue) {
        _tasks['overdueTasks']!.remove(_taskModel);
      } else {
        _tasks['completedTasks']!.remove(_taskModel);
      }
    }

    update();
  }
}
