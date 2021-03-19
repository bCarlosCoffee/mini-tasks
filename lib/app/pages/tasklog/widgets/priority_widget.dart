import 'package:flutter/material.dart';

Widget priorityWidget(
    {required String title, required bool checked, required Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: checked,
            activeColor: Colors.blueGrey,
            onChanged: (value) {
              onTap();
            },
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
}
