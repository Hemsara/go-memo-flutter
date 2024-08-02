import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastManager {
  static void showErrorToast(String message) {
    Fluttertoast.showToast(
      timeInSecForIosWeb: 3,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      msg: message,
    );
  }

  static void showWarningToast(String message) {
    Fluttertoast.showToast(
      msg: message,
    );
  }

  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.white,
      textColor: Colors.white,
      msg: message,
    );
  }
}
