import 'package:get/get.dart';
import 'package:todo_list/app/services/interfaces/task_local_notification_interface.dart';

class AppController {
  final TaskLocalNotificationsInterface localNotificationsService = Get.find();

  AppController() {
    localNotificationsService.init();
  }
}
