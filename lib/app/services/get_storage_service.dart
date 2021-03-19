import 'package:get_storage/get_storage.dart';
import 'package:todo_list/app/models/error_model.dart';
import 'package:todo_list/app/models/response_model.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/services/interfaces/task_storage_service_interface.dart';

class GetStorageService implements TaskStorageServiceInterface {
  final GetStorage service;

  GetStorageService(this.service);

  @override
  Future<ResponseModel> loadTasksOfTheDay(DateTime datetime) async {
    ErrorModel? _errorModel;
    List<TaskModel> _data = [];

    try {
      service.listenable().forEach((key, value) {
        if (DateTime.fromMillisecondsSinceEpoch(value['dateToPerformTask'])
                .day ==
            datetime.day) {
          _data.add(TaskModel.fromMap(value));
        }
      });
    } catch (e) {
      _errorModel = ErrorModel(
        type: e,
        message: 'Não foi possível carregar tarefas',
      );
    }

    return ResponseModel(error: _errorModel, result: _data);
  }

  @override
  Future<ResponseModel> uploadHistory(DateTime datetime) async {
    ErrorModel? _errorModel;
    List<TaskModel> _data = [];

    try {
      service.listenable().forEach((key, value) {
        _data.add(TaskModel.fromMap(value));
      });
    } catch (e) {
      _errorModel = ErrorModel(
        type: e,
        message: 'Não foi possível carregar histórico de tarefas',
      );
    }

    return ResponseModel(error: _errorModel, result: _data);
  }

  @override
  Future<ResponseModel> saveTask(TaskModel task) async {
    ErrorModel? errorModel;

    try {
      await service.write('${task.taskId}', task.toMap());
    } catch (e) {
      errorModel = ErrorModel(
        type: e,
        message: 'Não foi possível salvar tarefa',
      );
    }

    return ResponseModel(error: errorModel);
  }

  @override
  Future<ResponseModel> updateTask(TaskModel task) async {
    ErrorModel? errorModel;

    try {
      await service.write('${task.taskId}', task.toMap());
    } catch (e) {
      errorModel = ErrorModel(
        type: e,
        message: 'Não foi possível atualizar tarefa',
      );
    }

    return ResponseModel(error: errorModel);
  }

  @override
  Future<ResponseModel> deleteTask(TaskModel task) async {
    ErrorModel? errorModel;

    try {
      await service.remove('${task.taskId}');
    } catch (e) {
      errorModel = ErrorModel(
        type: e,
        message: 'Não foi possível apagar tarefa',
      );
    }

    return ResponseModel(error: errorModel);
  }
}
