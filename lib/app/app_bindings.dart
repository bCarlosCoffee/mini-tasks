import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:todo_list/app/services/flutter_local_notifications_service.dart';
import 'package:todo_list/app/services/interfaces/task_local_notification_interface.dart';

import 'app_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskLocalNotificationsInterface>(
      () => FlutterLocalNotificationsService(
        FlutterLocalNotificationsPlugin(),
      ),
    );
    Get.put(AppController());
  }
}
