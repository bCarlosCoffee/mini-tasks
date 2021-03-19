import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:todo_list/app/getx/task_log_getx.dart';
import 'package:todo_list/app/pages/tasklog/task_log_controller.dart';
import 'package:todo_list/app/widgets/floating_action_button_widget.dart';

import 'widgets/about_priority_widget.dart';
import 'widgets/priority_widget.dart';
import 'widgets/text_field_widget.dart';

class TaskLogPage extends StatelessWidget {
  final TaskLogController _controller;

  const TaskLogPage(this._controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_controller.editing ? 'Editar Tarefa' : 'Registrar Tarefa'),
        actions: !_controller.editing
            ? null
            : <Widget>[
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    if (!_controller.isLoading) {
                      _controller.deleteTask();
                    }
                  },
                ),
              ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GetBuilder<TaskLogGetx>(
        builder: (_) {
          return FloatingActionButtonWidget(
            icon: Icons.save,
            onTap: _controller.isLoading
                ? null
                : _controller.stateManager.formIsValid
                    ? _controller.editing
                        ? _controller.updateTask
                        : _controller.saveTask
                    : null,
          );
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              GetBuilder<TaskLogGetx>(
                builder: (_) {
                  return textFieldWidget(
                    context,
                    enabled: !_controller.isLoading,
                    initialValue: _controller.taskName,
                    labelText: 'Nome da Tarefa',
                    onChanged: _controller.stateManager.changeTaskName,
                    validator: _controller.stateManager.validateTaskName,
                  );
                },
              ),
              const SizedBox(height: 10),
              GetBuilder<TaskLogGetx>(
                builder: (_) {
                  return textFieldWidget(
                    context,
                    enabled: !_controller.isLoading,
                    initialValue: _controller.taskDescription,
                    labelText: 'Descrição da Tarefa',
                    onChanged: _controller.stateManager.changeTaskDescription,
                    validator: _controller.stateManager.validateTaskDescription,
                  );
                },
              ),
              const SizedBox(height: 10),
              GetBuilder<TaskLogGetx>(
                builder: (_) {
                  return ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.topLeft,
                    title: const Text('Prioridade da Tarefa'),
                    subtitle: Text(
                      _controller.taskPriority.toUpperCase(),
                      style: TextStyle(
                        color: _controller.taskPriority == 'baixa'
                            ? Colors.green
                            : _controller.taskPriority == 'média'
                                ? Colors.orange
                                : Colors.red,
                      ),
                    ),
                    children: _controller.isLoading
                        ? []
                        : [
                            if (_controller.taskPriority == 'baixa')
                              aboutPriorityWidget(
                                color: Colors.green.withOpacity(0.5),
                                content:
                                    'Na prioridade baixa: você não receberá notificações sobre a tarefa; será posicionada no final da lista;',
                              ),
                            if (_controller.taskPriority == 'média')
                              aboutPriorityWidget(
                                color: Colors.orange.withOpacity(0.5),
                                content:
                                    'Na prioridade média: você receberá notificações sobre a tarefa; a notificação será enviada em até um minuto antes de começar; será posicionada no meio da lista;',
                              ),
                            if (_controller.taskPriority == 'alta')
                              aboutPriorityWidget(
                                color: Colors.red.withOpacity(0.5),
                                content:
                                    'Na prioridade alta: você receberá notificações sobre a tarefa; a notificação será enviada em até três minutos antes de começar; será posicionada no topo da lista;',
                              ),
                            const SizedBox(height: 10),
                            priorityWidget(
                              onTap: () => _controller.stateManager
                                  .changeTaskPriority('alta'),
                              checked: _controller.stateManager.taskPriority ==
                                  'alta',
                              title: 'Prioridade Alta',
                            ),
                            priorityWidget(
                              onTap: () => _controller.stateManager
                                  .changeTaskPriority('média'),
                              checked: _controller.stateManager.taskPriority ==
                                  'média',
                              title: 'Prioridade Média',
                            ),
                            priorityWidget(
                              onTap: () => _controller.stateManager
                                  .changeTaskPriority('baixa'),
                              checked: _controller.stateManager.taskPriority ==
                                  'baixa',
                              title: 'Prioridade Baixa',
                            ),
                          ],
                  );
                },
              ),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () {
                  if (_controller.isLoading) return;
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    currentTime: DateTime.now(),
                    maxTime: DateTime(2023, 1, 1),
                    onChanged: _controller.stateManager.changeDateToPerformTask,
                    onConfirm: _controller.stateManager.changeDateToPerformTask,
                    locale: LocaleType.pt,
                  );
                },
                child: const Text(
                  'Quando Começa: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5.0,
                ),
                child: GetBuilder<TaskLogGetx>(
                  builder: (_) {
                    return Text(
                      _controller.formatDate(_controller.dateToPerformTask),
                    );
                  },
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  if (_controller.isLoading) return;
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    minTime: _controller.stateManager.dateToPerformTask,
                    currentTime: _controller.stateManager.dateToPerformTask,
                    maxTime: DateTime(2023, 1, 1),
                    onChanged: _controller.stateManager.changeDueDateOfTheTask,
                    onConfirm: _controller.stateManager.changeDueDateOfTheTask,
                    locale: LocaleType.pt,
                  );
                },
                child: const Text(
                  'Quando Termina: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5.0,
                ),
                child: GetBuilder<TaskLogGetx>(
                  builder: (_) {
                    return Text(
                      _controller.formatDate(_controller.dueDateOfTheTask),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
