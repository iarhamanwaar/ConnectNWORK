import 'package:connectnwork/constants.dart';
import 'package:flutter/material.dart';

class Utils {
  static showSnackbar(String? text) {
    if (text == null) return;

    final snackbar = SnackBar(
      content: Text(
        text,
      ),
      backgroundColor: Colors.red,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
