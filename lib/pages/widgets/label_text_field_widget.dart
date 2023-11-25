import 'package:flutter/material.dart';

class LabelTextField extends StatelessWidget {
  final String defaultText;
  final TextEditingController controller;
  final TextInputType inputType;

  const LabelTextField({Key? key, required this.defaultText, required this.controller, required this.inputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        keyboardType: inputType,
        controller: controller,
        decoration: InputDecoration(
            labelText: defaultText,
            labelStyle: const TextStyle(color: Colors.blue),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))),
      ),
    );
  }
}
