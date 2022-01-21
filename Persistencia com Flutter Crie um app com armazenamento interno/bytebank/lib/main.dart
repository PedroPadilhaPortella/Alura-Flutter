import 'package:flutter/material.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(const ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Dashboard(),
      theme: ThemeData(primaryColor: Colors.green[900]),
    );
  }
}
