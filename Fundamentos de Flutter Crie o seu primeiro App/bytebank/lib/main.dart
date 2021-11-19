import 'package:bytebank/screens/formulario_transferencia.dart';
import 'package:bytebank/screens/lista_transferencias.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          secondary: Colors.blueAccent[700],
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary),
      ),
      //home: ListaTransferencias(),
      initialRoute: '/',
      routes: {
        '/': (context) => ListaTransferencias(),
        '/add': (context) => FormularioTransferencia(),
      },
    );
  }
}
