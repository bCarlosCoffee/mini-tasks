import 'package:todo_list/app/models/response_model.dart';
import 'package:todo_list/app/models/task_model.dart';

abstract class TaskStorageServiceInterface {
  Future<ResponseModel> loadTasksOfTheDay(DateTime datetime);
  Future<ResponseModel> uploadHistory(DateTime datetime);
  Future<ResponseModel> saveTask(TaskModel taskModel);
  Future<ResponseModel> updateTask(TaskModel taskModel);
  Future<ResponseModel> deleteTask(TaskModel taskModel);
}
