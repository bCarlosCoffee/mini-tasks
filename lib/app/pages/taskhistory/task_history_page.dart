import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/app/getx/task_history_getx.dart';
import 'package:todo_list/app/routes/app_routes.dart';
import 'package:todo_list/app/widgets/drawer_widget.dart';
import 'package:todo_list/app/widgets/task_widget.dart';

import 'task_history_controller.dart';

class TaskHistoryPage extends StatelessWidget {
  final TaskHistoryController _controller;

  const TaskHistoryPage(this._controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
      ),
      drawer: DrawerWidget(1),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          GetBuilder<TaskHistoryGetx>(
            builder: (_) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _controller.tasks.length,
                itemBuilder: (BuildContext context, int taskIndex) {
                  if (_controller.tasks.length == taskIndex) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Aqui é o fim...\nPara adicionar uma nova tarefa, clique no botão:\n\' + Nova Tarefa\' localizado abaixo.',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                  return TaskWidget(
                    _controller.tasks[taskIndex],
                    taskIndex: taskIndex,
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
        ],
      ),
    );
  }
}
