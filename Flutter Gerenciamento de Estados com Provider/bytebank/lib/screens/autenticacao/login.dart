import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank/components/biometria.dart';
import 'package:bytebank/models/cliente.dart';
import 'package:bytebank/screens/autenticacao/register_form.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  final _localAuthentication = LocalAuthentication();

  Login({Key? key}) : super(key: key);

  bool _validateCPF(String cpf) {
    final cpfRegex = RegExp(r'\d{3}\.?\d{3}\.?\d{3}[-.]?\d{2}');
    return cpfRegex.hasMatch(cpf);
  }

  bool _validatePassword(String password) {
    final passwordRegex = RegExp(
        r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$*&@#])[0-9a-zA-Z$*&@#]{8,16}$');
    return passwordRegex.hasMatch(password);
  }

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

    if (isAuthenticated) {
      Provider.of<Cliente>(context, listen: false).biometria = isAuthenticated;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    }

    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => Dashboard()),
    //   (Route route) => false,
    // );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Faça seu Login",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(labelText: 'CPF'),
            keyboardType: TextInputType.number,
            controller: _cpfController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter()
            ],
            maxLength: 14,
            validator: (value) {
              if (!_validateCPF(value!)) {
                return "CPF inválido";
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(labelText: 'Senha'),
            keyboardType: TextInputType.text,
            controller: _senhaController,
            maxLength: 16,
            validator: (value) {
              if (value?.length == 0 || !_validatePassword(value!)) {
                return "Senha muito fraca";
              }
              return null;
            },
          ),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side:
                    BorderSide(width: 2, color: Theme.of(context).accentColor),
                textStyle: TextStyle(color: Theme.of(context).accentColor),
              ),
              child: Text(
                'CONTINUAR',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                    (route) => false,
                  );
                }
              },
            ),
          ),
          SizedBox(height: 15),
          FutureBuilder(
              future: _checkBiometryAvaliability(),
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: ElevatedButton(
                      onPressed: () async =>
                          await _authenticateCliente(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            width: 2, color: Theme.of(context).accentColor),
                        textStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                        backgroundColor: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Login via Biometria",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.fingerprint,
                              color: Theme.of(context).accentColor),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
          SizedBox(height: 15),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 2, color: Theme.of(context).accentColor),
              textStyle: TextStyle(color: Theme.of(context).accentColor),
            ),
            child: Text(
              'Criar uma conta >',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterForm()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/bytebank_logo.png',
                width: 200,
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: _buildForm(context)),
              ),
            ),
            SizedBox(height: 20),
          ],
        )),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
