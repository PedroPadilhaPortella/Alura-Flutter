import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:flutter/material.dart';
import 'components/theme.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(ByteBankApp(contactDAO: ContactDAO()));
}

class ByteBankApp extends StatelessWidget {
  final ContactDAO contactDAO;

  const ByteBankApp({Key? key, required this.contactDAO}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(contactDAO: contactDAO),
      theme: byteBankTheme,
    );
  }
}
