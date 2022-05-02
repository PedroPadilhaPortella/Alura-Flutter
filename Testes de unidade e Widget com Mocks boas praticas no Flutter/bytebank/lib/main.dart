import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/widgets/app_dependecies.dart';
import 'package:flutter/material.dart';
import 'components/theme.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(ByteBankApp(
    contactDAO: ContactDAO(),
    webClient: TransactionWebClient(),
  ));
}

class ByteBankApp extends StatelessWidget {
  final ContactDAO contactDAO;
  final TransactionWebClient webClient;

  const ByteBankApp(
      {Key? key, required this.contactDAO, required this.webClient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDAO: contactDAO,
      webClient: webClient,
      child: MaterialApp(
        home: const Dashboard(),
        theme: byteBankTheme,
      ),
    );
  }
}
