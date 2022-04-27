import 'package:bytebank/components/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationContainer extends BlocContainer {
  final Widget child;

  const LocalizationContainer({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CurrentLocateCubit(),
      child: child,
    );
  }
}

class CurrentLocateCubit extends Cubit<String> {
  CurrentLocateCubit() : super('en');
}
