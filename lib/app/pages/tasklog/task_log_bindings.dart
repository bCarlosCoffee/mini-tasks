import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_list/app/getx/task_log_getx.dart';
import 'package:todo_list/app/services/get_storage_service.dart';
import 'package:todo_list/app/services/interfaces/task_storage_service_interface.dart';

class TaskLogBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetStorage());
    Get.lazyPut<TaskStorageServiceInterface>(
        () => GetStorageService(Get.find()));
    //Get.lazyPut<TaskRepositoryInterface>(() => TaskRepository());
    Get.lazyPut(
      () => TaskLogGetx(Get.find()),
    );
  }
}
