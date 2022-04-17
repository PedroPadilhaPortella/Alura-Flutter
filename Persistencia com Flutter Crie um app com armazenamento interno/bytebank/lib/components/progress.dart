import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String message;
  const Progress({Key? key, this.message = "Loading"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.green),
          Text(message, style: const TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}

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
