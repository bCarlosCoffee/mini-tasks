import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';
import 'package:todo_list/app/getx/task_history_getx.dart';
import 'package:todo_list/app/getx/tasks_of_the_day_gext.dart';
import 'package:todo_list/app/models/response_model.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/services/interfaces/task_storage_service_interface.dart';
import 'package:todo_list/app/widgets/snackbar_widget.dart';

import '../app_controller.dart';

class TaskLogGetx extends GetxController {
  final TaskStorageServiceInterface _service;

  TaskLogGetx(this._service);

  TaskModel? taskToEdit;

  @override
  void onInit() {
    super.onInit();
    _fillInFields();
  }

  bool isLoading = false;
  void _changeIsLoading(bool value) {
    isLoading = value;
    update();
  }

  void _fillInFields() {
    _changeIsLoading(true);
    taskToEdit = Get.arguments;

    if (taskToEdit != null) {
      taskName = taskToEdit!.taskName;
      taskDescription = taskToEdit!.taskDescription;
      taskPriority = taskToEdit!.taskPriority;
      dateToPerformTask = taskToEdit!.dateToPerformTask;
      dueDateOfTheTask = taskToEdit!.dueDateOfTheTask;
    }
    _changeIsLoading(false);
  }

  String taskName = '';
  void changeTaskName(String value) => taskName = value.trim();
  String? validateTaskName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira o nome da tarefa.';
    }

    return null;
  }

  String taskDescription = '';
  void changeTaskDescription(String value) => taskDescription = value.trim();
  String? validateTaskDescription(String? value) => null;

  String taskPriority = 'baixa';
  void changeTaskPriority(String value) {
    taskPriority = value.trim().toLowerCase();
    update();
  }

  DateTime dateToPerformTask = DateTime.now();
  void changeDateToPerformTask(DateTime value) {
    dateToPerformTask = value;
    update();
  }

  DateTime dueDateOfTheTask = DateTime.now();
  void changeDueDateOfTheTask(DateTime value) {
    dueDateOfTheTask = value;
    update();
  }

  bool get formIsValid {
    return taskName.isNotEmpty;
  }

  bool areTheDatesValid() {
    final DateTime _today = DateTime.now();

    if (_today.isAfter(dateToPerformTask)) {
      snackbarWidget(
        message: 'Você não pode realizar tarefa na data definida...',
        isError: true,
      );
      return false;
    }

    if (dateToPerformTask.isBefore(dueDateOfTheTask)) {
      snackbarWidget(
        message: 'Você não pode terminar uma tarefa antes de começar...',
        isError: true,
      );
      return false;
    }

    return true;
  }

  void saveTask() async {
    if (!formIsValid) return;

    _changeIsLoading(true);

    final _today = DateTime.now();
    final TaskModel _taskModel = TaskModel.fromMap({
      'taskId': _today.hashCode,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'taskPriority': taskPriority,
      'dateToPerformTask': dateToPerformTask.millisecondsSinceEpoch,
      'dueDateOfTheTask': dueDateOfTheTask.millisecondsSinceEpoch,
      'taskCreationDate': _today.millisecondsSinceEpoch,
      'taskCompleted': false,
    });

    final ResponseModel _responseModel = await _service.saveTask(_taskModel);

    if (_responseModel.error != null) {
      snackbarWidget(
        message: _responseModel.error!.message!,
        isError: true,
      );
    } else {
      if (_taskModel.taskPriority == 'alta' ||
          _taskModel.taskPriority == 'média') {
        setAlarm(_taskModel, _taskModel.taskPriority);
      }

      Get.find<TasksOfTheDayGext>().load();
      Get.back();

      if (_today.day == _taskModel.dateToPerformTask.day) {
        snackbarWidget(
          message: 'Tarefa salva!',
        );
      } else {
        snackbarWidget(
          message: 'Tarefa salva no histórico!',
        );
      }
    }

    _changeIsLoading(false);
  }

  void setAlarm(TaskModel _taskModel, String priority) {
    int _minutes = 3;

    if (priority == 'alta') {
      if (DateTime.now().isAfter(
        dateToPerformTask.subtract(
          Duration(minutes: _minutes),
        ),
      )) {
        _minutes -= 1;
        if (DateTime.now().isAfter(
          dateToPerformTask.subtract(
            Duration(minutes: _minutes),
          ),
        )) {
          return;
        }
      }
    } else {
      _minutes = 1;
      if (DateTime.now().isAfter(
        dateToPerformTask.subtract(
          Duration(minutes: _minutes),
        ),
      )) {
        return;
      }
    }

    Get.find<AppController>().localNotificationsService.scheduleNotification(
          id: _taskModel.taskId,
          title: priority == 'média'
              ? 'Opa, Não esqueça...'
              : 'Olá, já está quase na hora!',
          body: _taskModel.taskName,
          scheduledDate: dateToPerformTask.subtract(
            Duration(minutes: _minutes),
          ),
          channelID: '${_taskModel.taskId}',
          channelName: priority == 'média'
              ? 'Tarefas Importantes'
              : 'Tarefas Muito Importantes',
          channelDescription: priority == 'média'
              ? 'Tarefas de média prioridade são adicionadas aqui'
              : 'Tarefas de alta prioridade são adicionadas aqui',
        );
  }

  void updateTask() async {
    _changeIsLoading(true);
    taskToEdit!.taskName = taskName;
    taskToEdit!.taskDescription = taskDescription;
    taskToEdit!.dateToPerformTask = dateToPerformTask;
    taskToEdit!.dueDateOfTheTask = dueDateOfTheTask;

    final ResponseModel _responseModel = await _service.updateTask(taskToEdit!);

    if (_responseModel.error != null) {
      snackbarWidget(
        message: _responseModel.error!.message!,
        isError: true,
      );
    } else {
      if (taskToEdit!.taskPriority == 'alta' ||
          taskToEdit!.taskPriority == 'média') {
        Get.find<AppController>().localNotificationsService.cancelNotification(
              taskToEdit!.taskId,
            );
      }

      try {
        Get.find<TasksOfTheDayGext>().removeTask(taskToEdit);
        Get.find<TasksOfTheDayGext>().load();
      } catch (e) {
        try {
          Get.find<TaskHistoryGetx>().removeTask(taskToEdit!);
          Get.find<TaskHistoryGetx>().load();
        } catch (e) {}
      }
      Get.back();
      snackbarWidget(
        message: 'Tarefa atualizada!',
      );
    }
    _changeIsLoading(false);
  }

  void deleteTask() async {
    _changeIsLoading(true);
    final ResponseModel _responseModel = await _service.deleteTask(taskToEdit!);

    if (_responseModel.error != null) {
      snackbarWidget(
        message: _responseModel.error!.message!,
        isError: true,
      );
    } else {
      if (taskToEdit!.taskPriority == 'alta' ||
          taskToEdit!.taskPriority == 'média') {
        Get.find<AppController>().localNotificationsService.cancelNotification(
              taskToEdit!.taskId,
            );
      }

      try {
        Get.find<TasksOfTheDayGext>().removeTask(taskToEdit!);
        Get.find<TasksOfTheDayGext>().load();
      } catch (e) {
        try {
          Get.find<TaskHistoryGetx>().removeTask(taskToEdit!);
          Get.find<TaskHistoryGetx>().load();
        } catch (e) {}
      }
      Get.back();
      snackbarWidget(
        message: 'Tarefa removida!',
      );
    }
    _changeIsLoading(false);
  }
}
