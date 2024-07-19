import 'package:flutter/material.dart';

showSnackBar(String content, BuildContext context, String status) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(child: Text(content)),
    backgroundColor: changeColor(status, context),
  ));
}

Color changeColor(String status, BuildContext context) {
  if (status == "ok") {
    return Theme.of(context).colorScheme.secondary;
  } else {
    return Colors.redAccent;
  }
}
