import 'package:bytebank/models/cliente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class Biometria extends StatelessWidget {
  final _localAuthentication = LocalAuthentication();

  Biometria({Key? key}) : super(key: key);

  _checkBiometryAvaliability() async {
    try {
      return await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (err) {
      print(err);
    }
  }

  Future<void> _authenticateCliente(context) async {
    bool isAuthenticated = false;

    isAuthenticated = await _localAuthentication.authenticate(
      localizedReason: 'Autentique-se para continuar',
      options: AuthenticationOptions(useErrorDialogs: true, stickyAuth: true),
    );

    Provider.of<Cliente>(context).biometria = isAuthenticated;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _checkBiometryAvaliability(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                children: [
                  Text(
                    "Detectamos que você tem sensor biométrico no seu smartphone, deseja cadastrar a sua biometria?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      await _authenticateCliente(context);
                    },
                    child: Text("Habilitar impressão digital"),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
