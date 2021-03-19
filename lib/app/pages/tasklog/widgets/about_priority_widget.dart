import 'package:flutter/material.dart';

Widget aboutPriorityWidget({required Color color, required String content}) {
  return Container(
    width: double.maxFinite,
    padding: const EdgeInsets.all(8),
    color: color,
    child: Text(
      content,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
