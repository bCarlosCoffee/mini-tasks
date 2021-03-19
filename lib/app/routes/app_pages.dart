import 'package:get/get.dart';
import 'package:todo_list/app/pages/taskhistory/task_history_bindings.dart';
import 'package:todo_list/app/pages/taskhistory/task_history_controller.dart';
import 'package:todo_list/app/pages/taskhistory/task_history_page.dart';
import 'package:todo_list/app/pages/tasklog/task_log_bindings.dart';
import 'package:todo_list/app/pages/tasklog/task_log_controller.dart';
import 'package:todo_list/app/pages/tasklog/task_log_page.dart';
import 'package:todo_list/app/pages/tasksoftheday/tasks_of_the_day_bindings.dart';
import 'package:todo_list/app/pages/tasksoftheday/tasks_of_the_day_controller.dart';
import 'package:todo_list/app/pages/tasksoftheday/tasks_of_the_day_page.dart';

import 'app_routes.dart';

final getPages = [
  GetPage(
    name: AppRoutes.TASKS_OF_THE_DAY_ROUTE,
    page: () => TasksOfTheDayPage(TasksOfTheDayController(Get.find())),
    binding: TasksOfTheDayBindings(),
  ),
  GetPage(
    name: AppRoutes.TASK_LOG_ROUTE,
    page: () => TaskLogPage(TaskLogController(Get.find())),
    binding: TaskLogBindings(),
  ),
  GetPage(
    name: AppRoutes.TASK_HISTORY_ROUTE,
    page: () => TaskHistoryPage(TaskHistoryController(Get.find())),
    binding: TaskHistoryBindings(),
  ),
];
