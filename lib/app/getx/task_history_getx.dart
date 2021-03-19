import 'package:get/get.dart';
import 'package:todo_list/app/models/response_model.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/services/interfaces/task_storage_service_interface.dart';
import 'package:todo_list/app/widgets/snackbar_widget.dart';

class TaskHistoryGetx extends GetxController {
  final TaskStorageServiceInterface _service;

  TaskHistoryGetx(this._service);

  List<TaskModel> tasks = [];

  @override
  void onInit() async {
    super.onInit();
    load();
  }

  bool isLoading = false;
  _changeIsLoading(bool value) {
    isLoading = value;
    update();
  }

  void load() async {
    _changeIsLoading(true);

    final ResponseModel _responseModel =
        await _service.uploadHistory(DateTime.now());

    if (_responseModel.error != null) {
      snackbarWidget(
        message: _responseModel.error!.message!,
        isError: true,
      );
    } else {
      tasks = _responseModel.result;
      _organizeTasks();
    }

    _changeIsLoading(false);
  }

  void _organizeTasks() {
    tasks.sort(
      (a, b) => a.taskCreationDate.isBefore(b.taskCreationDate) ? 1 : -1,
    );

    update();
  }

  void removeTask(TaskModel task) {
    _changeIsLoading(true);
    tasks.remove(task);
    _changeIsLoading(false);
  }
}
