import 'package:bytebank/models/cliente.dart';
import 'package:bytebank/screens/autenticacao/login.dart';
import 'package:bytebank/screens/dashboard/saldo.dart';
import 'package:bytebank/screens/deposito/formulario.dart';
import 'package:bytebank/screens/extrato/ultimas.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bytebank'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Consumer<Cliente>(
            builder: (context, cliente, child) {
              if (cliente.nome != '') {
                return Text(
                  'Bem vindo ${cliente.nome.split(' ')[0]}, o seu saldo atual é de',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                );
              }
              return Text(
                'Seu seu saldo atual é de',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              );
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text('Recebe valor'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return FormularioDeposito();
                    }),
                  );
                },
              ),
              ElevatedButton(
                child: Text('Nova Transferência'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return FormularioTransferencia();
                    }),
                  );
                },
              )
            ],
          ),
          UltimasTransferencias(),
        ],
      ),
    );
  }
}
