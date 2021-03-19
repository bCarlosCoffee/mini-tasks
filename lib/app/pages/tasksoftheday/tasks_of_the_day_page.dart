import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/app/getx/tasks_of_the_day_gext.dart';
import 'package:todo_list/app/routes/app_routes.dart';
import 'package:todo_list/app/widgets/drawer_widget.dart';
import 'package:todo_list/app/widgets/floating_action_button_widget.dart';

import 'tasks_of_the_day_controller.dart';
import '../../widgets/task_widget.dart';

class TasksOfTheDayPage extends StatelessWidget {
  final TasksOfTheDayController _controller;

  const TasksOfTheDayPage(this._controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas de Hoje'),
      ),
      drawer: DrawerWidget(0),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          GetBuilder<TasksOfTheDayGext>(
            builder: (_) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _controller.tasks.length,
                itemBuilder: (BuildContext context, int taskIndex) {
                  return TaskWidget(
                    _controller.tasks[taskIndex],
                    taskIndex: taskIndex,
                    markAsDone: () {
                      _controller.stateManager.markAsDone(taskIndex);
                    },
                    more: () {
                      Get.toNamed(
                        AppRoutes.TASK_LOG_ROUTE,
                        arguments: _controller.tasks[taskIndex],
                      );
                    },
                  );
                },
              );
            },
          ),
          FloatingActionButtonWidget(
            icon: Icons.add,
            onTap: () => Get.toNamed(AppRoutes.TASK_LOG_ROUTE),
          ),
        ],
      ),
    );
  }
}
