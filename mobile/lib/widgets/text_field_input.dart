import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vetlink/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      this.isPass = false,
      required this.hintText,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        fillColor: mobileBackgroundColor,
        contentPadding: const EdgeInsets.all(15),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
