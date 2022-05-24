import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank/screens/autenticacao/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dashboard/dashboard.dart';

class Register extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  Register({Key? key}) : super(key: key);

  bool _validateCPF(String cpf) {
    final cpfRegex = RegExp(r'\d{3}\.?\d{3}\.?\d{3}[-.]?\d{2}');
    return cpfRegex.hasMatch(cpf);
  }

  bool _validatePassword(String password) {
    final passwordRegex = RegExp(
        r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$*&@#])[0-9a-zA-Z$*&@#]{8,16}$');
    return passwordRegex.hasMatch(password);
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Crie sua Conta",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          TextFormField(
            decoration: InputDecoration(labelText: 'Nome'),
            keyboardType: TextInputType.text,
            controller: _nomeController,
            maxLength: 100,
            validator: (value) {
              if (value!.isEmpty || value.length < 3) {
                return "Nome inválido";
              }
              return null;
            },
          ),
          SizedBox(height: 15),
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
          SizedBox(height: 15),
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
              child: Text('CONTINUAR'),
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
          Text(
            "Esqueci minha senha >",
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 2, color: Theme.of(context).accentColor),
              textStyle: TextStyle(color: Theme.of(context).accentColor),
            ),
            child: Text(
              'Fazer seu Login >',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
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
                height: 650,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: _buildForm(context)),
              ),
            ),
            SizedBox(height: 15),
          ],
        )),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
