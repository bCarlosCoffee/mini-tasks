import 'package:todo_list/app/models/error_model.dart';

class ResponseModel {
  final ErrorModel? error;
  final dynamic? result;
  ResponseModel({
    this.error,
    this.result,
  });
}
