import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormularioTransferencia(),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final _fieldControllerAccount = TextEditingController();
  final _fieldControllerValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Adicionar Transferência")),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _fieldControllerAccount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Número da Conta", hintText: "000000"),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _fieldControllerValue,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Valor",
                    hintText: "0,00",
                    icon: Icon(Icons.monetization_on)),
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint('clicou no confirmar');
                final int? conta = int.tryParse(_fieldControllerAccount.text);
                final double? valor =
                    double.tryParse(_fieldControllerValue.text);

                if (conta != null && valor != null) {
                  final transferenciaCriada = Transferencia(valor, conta);
                  debugPrint('$transferenciaCriada');
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$transferenciaCriada')));
                }
              },
              child: Text("Salvar"),
              style: ElevatedButton.styleFrom(
                  elevation: 10,
                  fixedSize: Size(100, 40),
                  textStyle: TextStyle(fontSize: 20)),
            )
          ],
        ));
  }
}

class ListaTranferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transferências")),
      body: Column(
        children: [
          ItemTranferencia(Transferencia(100, 1234)),
          ItemTranferencia(Transferencia(100, 1234)),
          ItemTranferencia(Transferencia(100, 1234)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class ItemTranferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTranferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text("R\$ ${_transferencia.valor.toString()}"),
      subtitle: Text("Conta: ${_transferencia.conta.toString()}"),
    ));
  }
}

class Transferencia {
  final double valor;
  final int conta;

  Transferencia(this.valor, this.conta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $conta}';
  }
}
