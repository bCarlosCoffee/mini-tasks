import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackbarWidget({required String message, bool isError = false}) {
  Get.rawSnackbar(
    messageText: Text(message, style: const TextStyle(color: Colors.white)),
    borderRadius: 40.0,
    margin: const EdgeInsets.only(
      top: 40.0,
      left: 5.0,
      right: 5.0,
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError ? Colors.red : Theme.of(Get.context).accentColor,
    boxShadows: <BoxShadow>[
      BoxShadow(
        color: isError ? Colors.red : Theme.of(Get.context).accentColor,
        blurRadius: 18.0,
        spreadRadius: 0.0,
      ),
    ],
  );
}
