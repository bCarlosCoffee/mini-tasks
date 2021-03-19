import 'package:get/get.dart';
import 'package:todo_list/app/getx/tasks_of_the_day_gext.dart';
import 'package:todo_list/app/models/task_model.dart';

import '../../app_controller.dart';

class TasksOfTheDayController {
  final TasksOfTheDayGext stateManager;

  TasksOfTheDayController(this.stateManager);

  List<TaskModel> get tasks => stateManager.tasks;

  show() {
    Get.find<AppController>().localNotificationsService.showNotification(
          channelID: 'ID de Teste',
          channelDescription: 'Descrição de Teste',
          channelName: 'Nome de Teste',
        );
  }
}
