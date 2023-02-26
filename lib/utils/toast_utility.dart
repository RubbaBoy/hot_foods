import 'package:flutter/material.dart';

void sendToast(BuildContext context, String name) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(name),
  ));
}
