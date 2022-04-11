import 'package:flutter/material.dart';
import 'components/theme.dart';
import 'screens/counter_page.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(const ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterContainer(),
      theme: ByteBankTheme,
    );
  }
}
