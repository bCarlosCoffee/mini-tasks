import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/app/models/task_model.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel _taskModel;
  final int? taskIndex;
  final Function()? markAsDone;
  final Function()? more;

  const TaskWidget(
    this._taskModel, {
    Key? key,
    this.taskIndex,
    this.markAsDone,
    this.more,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: const SlidableScrollActionPane(),
      actionExtentRatio: 0.25,
      child: Opacity(
        opacity: _taskModel.taskCompleted ? 0.5 : 1.0,
        child: Container(
          child: ListTile(
            isThreeLine: true,
            title: Text(
              _taskModel.taskName,
              style: TextStyle(
                color: _taskModel.taskIsOverdue && !_taskModel.taskCompleted
                    ? Colors.red
                    : null,
                decoration: _taskModel.taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              _taskModel.taskDescription,
              style: TextStyle(
                color: _taskModel.taskIsOverdue && !_taskModel.taskCompleted
                    ? Colors.red
                    : null,
                decoration: _taskModel.taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: Text(
              _taskModel.dateToPerformFormattedTask,
              style: TextStyle(
                color: _taskModel.taskIsOverdue && !_taskModel.taskCompleted
                    ? Colors.red
                    : Colors.grey,
                decoration: _taskModel.taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        _taskModel.taskIsOverdue
            ? Container()
            : IconSlideAction(
                caption: _taskModel.taskCompleted ? 'Não\nFeito' : 'Feito!',
                color: _taskModel.taskCompleted ? Colors.red : Colors.green,
                icon: _taskModel.taskCompleted ? Icons.close : Icons.check,
                onTap: _taskModel.taskIsOverdue ? null : markAsDone,
              ),
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: more,
        ),
      ],
    );
  }
}
