import 'package:flutter/material.dart';

class ConfirmationBox extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmationBox(
      {Key? key,
      required this.title,
      required this.content,
      required this.onConfirm,
      required this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onCancel();
            },
            child: Text('لغو')),
        TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blue),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: Text('تایید')),
      ],
    );
  }
}
