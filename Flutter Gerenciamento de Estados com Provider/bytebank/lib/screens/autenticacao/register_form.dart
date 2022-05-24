import 'package:brasil_fields/brasil_fields.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:bytebank/models/cliente.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../dashboard/dashboard.dart';

class RegisterForm extends StatelessWidget {
  //Step 1
  final _formUserData = new GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();

  //Step 2
  final _formUserAddress = new GlobalKey<FormState>();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  //Step 3
  final _formUserAuth = new GlobalKey<FormState>();
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

  _nextStep(BuildContext context) {
    Cliente cliente = Provider.of<Cliente>(context, listen: false);
    goTo(cliente.stepAtual + 1, cliente);
  }

  goTo(int step, Cliente cliente) {
    cliente.stepAtual = step;
  }

  void _saveStep1(BuildContext context) {
    if (_formUserData.currentState!.validate()) {
      Cliente cliente = Provider.of<Cliente>(context, listen: false);
      cliente.nome = _nomeController.text;
      cliente.email = _emailController.text;
      cliente.cpf = _cpfController.text;
      cliente.telefone = _telefoneController.text;
      cliente.dataNascimento = _nascimentoController.text;
      _nextStep(context);
    }
  }

  void _saveStep2(BuildContext context) {
    if (_formUserAddress.currentState!.validate()) {
      Cliente cliente = Provider.of<Cliente>(context, listen: false);
      cliente.cep = _cepController.text;
      cliente.estado = _estadoController.text;
      cliente.cidade = _cidadeController.text;
      cliente.bairro = _bairroController.text;
      cliente.logradouro = _logradouroController.text;
      cliente.numero = _numeroController.text;
      _nextStep(context);
    }
  }

  void _saveStep3(BuildContext context) {
    if (_formUserAuth.currentState!.validate()) {
      Cliente cliente = Provider.of<Cliente>(context, listen: false);
      cliente.senha = _senhaController.text;
      FocusScope.of(context).unfocus();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
        (Route route) => false,
      );
    }
  }

  List<Step> _buildSteps(BuildContext context, Cliente cliente) {
    List<Step> steps = [
      Step(
        title: Text("Dados Pessoais"),
        isActive: cliente.stepAtual >= 0,
        content: Form(
          key: _formUserData,
          child: Column(children: [
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
                if (!_validateEmail(value!) && !Validator.email(value)) {
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
                if (!_validateCPF(value!) && !Validator.cpf(value)) {
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
                if (!_validateTelefone(value!) && !Validator.phone(value)) {
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
          ]),
        ),
      ),
      Step(
        title: Text("Endereço"),
        isActive: cliente.stepAtual >= 1,
        content: Form(
          key: _formUserAddress,
          child: Column(children: [
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
                if (!_validateCEP(value!) && !Validator.cep(value)) {
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
              decoration: InputDecoration(labelText: 'Endereço (Logradouro)'),
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
          ]),
        ),
      ),
      Step(
        title: Text("Autenticação"),
        isActive: cliente.stepAtual >= 2,
        content: Form(
          key: _formUserAuth,
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Senha'),
              keyboardType: TextInputType.text,
              controller: _senhaController,
              obscureText: true,
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
              obscureText: true,
              maxLength: 16,
              validator: (value) {
                if (!_confirmPassword(value!)) {
                  return "As senha são diferentes";
                }
                return null;
              },
            ),
          ]),
        ),
      ),
    ];
    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Cliente'),
        backgroundColor: Color.fromRGBO(71, 161, 56, 1),
      ),
      body: Consumer<Cliente>(
        builder: (context, cliente, child) {
          return Stepper(
            currentStep: cliente.stepAtual,
            onStepContinue: () {
              final functions = [
                _saveStep1,
                _saveStep2,
                _saveStep3,
              ];
              return functions[cliente.stepAtual](context);
            },
            onStepCancel: () {
              cliente.stepAtual =
                  cliente.stepAtual > 0 ? cliente.stepAtual - 1 : 0;
            },
            steps: _buildSteps(context, cliente),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: Text('Salvar'),
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    ElevatedButton(
                      onPressed: details.onStepCancel,
                      child: Text('Voltar'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
