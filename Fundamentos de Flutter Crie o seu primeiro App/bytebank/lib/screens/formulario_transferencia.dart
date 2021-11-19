import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TITULO_APP_BAR = "Adicionar Transferência";

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final _fieldControllerAccount = TextEditingController();
  final _fieldControllerValue = TextEditingController();

  void _saveTransfer(BuildContext context) {
    final int? conta = int.tryParse(_fieldControllerAccount.text);
    final double? valor = double.tryParse(_fieldControllerValue.text);

    if (conta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, conta);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$transferenciaCriada')));
      Navigator.pop(context, transferenciaCriada);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(TITULO_APP_BAR)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Editor(
                  controller: _fieldControllerAccount,
                  label: "Número da Conta",
                  hint: "00000-00"),
              Editor(
                  controller: _fieldControllerValue,
                  label: "Valor",
                  hint: "0.00",
                  icon: Icons.monetization_on),
              ElevatedButton(
                onPressed: () => _saveTransfer(context),
                child: Text("Salvar"),
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    fixedSize: Size(100, 40),
                    textStyle: TextStyle(fontSize: 20)),
              )
            ],
          ),
        ));
  }
}
