import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/device_controller.dart';

class SnackbarService {
  final BuildContext context;
 SnackbarService(this.context);

  void ShowSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
  }

  void ShowErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }
}
