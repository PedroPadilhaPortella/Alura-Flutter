import 'package:flutter/material.dart';
import 'database/app_database.dart';
import 'models/contact.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(const ByteBankApp());
    findAll().then((contacts) => debugPrint(contacts.toString()));
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      theme: ThemeData(primaryColor: Colors.green[900]),
    );
  }
}
