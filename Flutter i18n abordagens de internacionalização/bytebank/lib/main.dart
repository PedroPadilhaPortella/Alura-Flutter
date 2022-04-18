import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/theme.dart';
import 'screens/dashboard.dart';

class LogObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('${bloc.runtimeType} > $change');
    super.onChange(bloc, change);
  }
}

void main() {
  BlocOverrides.runZoned(
    () => runApp(const ByteBankApp()),
    blocObserver: LogObserver(),
  );
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DashboardContainer(),
      theme: ByteBankTheme,
    );
  }
}
