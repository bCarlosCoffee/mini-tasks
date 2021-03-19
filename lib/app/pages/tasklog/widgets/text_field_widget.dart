import 'package:flutter/material.dart';

Widget textFieldWidget(
  BuildContext context, {
  String? initialValue,
  TextEditingController? controller,
  String? labelText,
  bool enabled = true,
  Function(String)? onChanged,
  String? Function(String?)? validator,
  int maxLines = 1,
}) {
  return TextFormField(
    keyboardType: TextInputType.text,
    controller: controller,
    initialValue: initialValue,
    enabled: enabled,
    autofocus: false,
    maxLines: maxLines,
    autovalidateMode: AutovalidateMode.always,
    onChanged: onChanged,
    validator: validator,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey),
      ),
      labelText: labelText,
    ),
  );
}
