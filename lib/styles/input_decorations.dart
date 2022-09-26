////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
class InputDecorations {
  static InputDecoration loginInputDecoration(
      {
        required Icon prefixIcon,
        required String hintText,
        required String labelText
      }) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
