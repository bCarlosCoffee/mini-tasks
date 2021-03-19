import 'dart:convert';

class TaskModel {
  final int taskId;
  String taskName;
  String taskDescription;

  /// valid: low, medium and high
  String taskPriority;

  dynamic dateToPerformTask;
  dynamic dueDateOfTheTask;
  final taskCreationDate;

  bool taskCompleted;

  TaskModel(
    this.taskId,
    this.taskName,
    this.taskDescription,
    this.taskPriority,
    this.dateToPerformTask,
    this.dueDateOfTheTask,
    this.taskCreationDate,
    this.taskCompleted,
  );

  String get dateToPerformFormattedTask {
    return '${dateToPerformTask.hour}:${dateToPerformTask.minute} até ${dueDateOfTheTask.hour}:${dueDateOfTheTask.minute}';
  }

  bool get taskIsOverdue {
    return DateTime.now().isAfter(dueDateOfTheTask);
  }

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'taskPriority': taskPriority,
      'dateToPerformTask': dateToPerformTask.millisecondsSinceEpoch,
      'dueDateOfTheTask': dueDateOfTheTask.millisecondsSinceEpoch,
      'taskCreationDate': taskCreationDate.millisecondsSinceEpoch,
      'taskCompleted': taskCompleted,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      map['taskId'],
      map['taskName'],
      map['taskDescription'],
      map['taskPriority'],
      DateTime.fromMillisecondsSinceEpoch(map['dateToPerformTask']),
      DateTime.fromMillisecondsSinceEpoch(map['dueDateOfTheTask']),
      DateTime.fromMillisecondsSinceEpoch(map['taskCreationDate']),
      map['taskCompleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));
}
