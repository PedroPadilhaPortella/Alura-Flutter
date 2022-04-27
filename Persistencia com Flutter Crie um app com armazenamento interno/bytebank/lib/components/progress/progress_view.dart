import 'package:bytebank/components/progress/progress.dart';
import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  final String message;
  final String title;
  const ProgressView({Key? key, required this.message, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title), backgroundColor: Theme.of(context).primaryColor),
      body: Progress(message: message),
    );
  }
}
