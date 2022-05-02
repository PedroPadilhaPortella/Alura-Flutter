import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:flutter/material.dart';

class AppDependencies extends InheritedWidget {
  final ContactDAO contactDAO;
  final TransactionWebClient webClient;

  const AppDependencies(
      {Key? key,
      required this.contactDAO,
      required this.webClient,
      required Widget child})
      : super(key: key, child: child);

  static AppDependencies of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDependencies>()!;
  }

  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) {
    return contactDAO != oldWidget.contactDAO ||
        webClient != oldWidget.webClient;
  }
}
