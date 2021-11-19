import 'package:bytebank/components/item_transferencia.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'formulario_transferencia.dart';

const TITULO_APP_BAR = "Transferências";

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia?> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTranferenciasState();
  }
}

class ListaTranferenciasState extends State<ListaTransferencias> {
  void _atualiza(Transferencia? transferencia) {
    if (transferencia != null) {
      setState(() {
        widget._transferencias.add(transferencia);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(TITULO_APP_BAR)),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, i) {
          final transferencia = widget._transferencias[i];
          return ItemTranferencia(transferencia!);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //final Future<Transferencia?> future =
          //    Navigator.push(context, MaterialPageRoute(builder: (context) {
          //return FormularioTransferencia();
          //}));
          final Future future = Navigator.pushNamed(context, "/add");
          future.then((transferencia) => _atualiza(transferencia));
        },
      ),
    );
  }
}
