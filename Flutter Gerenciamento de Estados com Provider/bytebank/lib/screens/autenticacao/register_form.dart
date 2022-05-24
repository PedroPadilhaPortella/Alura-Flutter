import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank/models/cliente.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../dashboard/dashboard.dart';

class RegisterForm extends StatelessWidget {
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _repitaSenhaController = TextEditingController();

  RegisterForm({Key? key}) : super(key: key);

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^([\w-]\.?)+@([\w-]+\.)+([A-Za-z]{2,4})+$');
    return emailRegex.hasMatch(email);
  }

  bool _validateCPF(String cpf) {
    final cpfRegex = RegExp(r'\d{3}\.?\d{3}\.?\d{3}[-.]?\d{2}');
    return cpfRegex.hasMatch(cpf);
  }

  bool _validateCEP(String cep) {
    final cepRegex = RegExp(r'\d{2}\.\d{3}-\d{3}');
    return cepRegex.hasMatch(cep);
  }

  bool _validateTelefone(String telefone) {
    final telefoneRegex = RegExp(r'\(\d{2}\) \d{4,5}-\d{4}');
    return telefoneRegex.hasMatch(telefone);
  }

  bool _validatePassword(String password) {
    final passwordRegex = RegExp(
        r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$*&@#])[0-9a-zA-Z$*&@#]{8,16}$');
    return passwordRegex.hasMatch(password);
  }

  bool _confirmPassword(String confirmPassword) {
    return confirmPassword == _senhaController.text;
  }

  void _salvar(context) {
    Provider.of<Cliente>(context, listen: false).nome = _nomeController.text;
    Provider.of<Cliente>(context, listen: false).email = _emailController.text;
    Provider.of<Cliente>(context, listen: false).cpf = _cpfController.text;
    Provider.of<Cliente>(context, listen: false).bairro =
        _bairroController.text;
    Provider.of<Cliente>(context, listen: false).cep = _cepController.text;
    Provider.of<Cliente>(context, listen: false).cidade =
        _cidadeController.text;
    Provider.of<Cliente>(context, listen: false).telefone =
        _telefoneController.text;
    Provider.of<Cliente>(context, listen: false).dataNascimento =
        _nascimentoController.text;
    Provider.of<Cliente>(context, listen: false).estado =
        _estadoController.text;
    Provider.of<Cliente>(context, listen: false).logradouro =
        _logradouroController.text;
    Provider.of<Cliente>(context, listen: false).numero =
        _numeroController.text;
    Provider.of<Cliente>(context, listen: false).senha = _senhaController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Cliente'),
        backgroundColor: Color.fromRGBO(71, 161, 56, 1),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 3) {
                      return "Nome inválido";
                    }
                    if (!value.contains(" ")) {
                      return "Escreva ao menos um sobrenome";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 255,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (!_validateEmail(value!)) {
                      return "Email inválido";
                    }
                    return null;
                  },
                ),
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'Telefone'),
                  keyboardType: TextInputType.number,
                  controller: _telefoneController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter()
                  ],
                  maxLength: 14,
                  validator: (value) {
                    if (!_validateTelefone(value!)) {
                      return "Telefone inválido";
                    }
                    return null;
                  },
                ),
                DateTimePicker(
                  controller: _nascimentoController,
                  type: DateTimePickerType.date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2030),
                  dateLabelText: 'Data de Nascimento',
                  dateMask: 'dd/MM/yyyy',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Data de nascimento inválida";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'CEP'),
                  keyboardType: TextInputType.number,
                  controller: _cepController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter()
                  ],
                  maxLength: 10,
                  validator: (value) {
                    if (!_validateCEP(value!)) {
                      return "CEP inválido";
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  hint: Text('Estado'),
                  isExpanded: true,
                  items: Estados.listaEstados.map((String estado) {
                    return DropdownMenuItem(
                      value: estado,
                      child: Text(estado),
                    );
                  }).toList(),
                  onChanged: (String? estado) {
                    _estadoController.text = estado!;
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Selecione um Estado";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Cidade'),
                  keyboardType: TextInputType.text,
                  controller: _cidadeController,
                  maxLength: 255,
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return "Cidade inválido";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Bairro'),
                  keyboardType: TextInputType.text,
                  controller: _bairroController,
                  maxLength: 255,
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return "Bairro inválido";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Endereço (Logradouro)'),
                  keyboardType: TextInputType.text,
                  controller: _logradouroController,
                  maxLength: 255,
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return "Endereço inválido";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Número'),
                  keyboardType: TextInputType.text,
                  controller: _numeroController,
                  maxLength: 255,
                ),
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'Repita a Senha'),
                  keyboardType: TextInputType.text,
                  controller: _repitaSenhaController,
                  maxLength: 16,
                  validator: (value) {
                    if (!_confirmPassword(value!)) {
                      return "As senha são diferentes";
                    }
                    return null;
                  },
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        width: 2, color: Theme.of(context).accentColor),
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
                      _salvar(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                        (route) => false,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
