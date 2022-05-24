import 'package:flutter/material.dart';

class Cliente extends ChangeNotifier {
  late String _nome;
  late String _email;
  late String _telefone;
  late String _cpf;
  late String _dataNascimento;
  late String _cep;
  late String _estado;
  late String _cidade;
  late String _bairro;
  late String _logradouro;
  late String _numero;
  late String _senha;

  String get nome => _nome;

  String get email => _email;

  String get telefone => _telefone;

  String get cpf => _cpf;

  String get dataNascimento => _dataNascimento;

  String get cep => _cep;

  String get estado => _estado;

  String get cidade => _cidade;

  String get bairro => _bairro;

  String get logradouro => _logradouro;

  String get numero => _numero;

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
    notifyListeners();
  }

  set numero(String value) {
    _numero = value;
    notifyListeners();
  }

  set logradouro(String value) {
    _logradouro = value;
    notifyListeners();
  }

  set bairro(String value) {
    _bairro = value;
    notifyListeners();
  }

  set cidade(String value) {
    _cidade = value;
    notifyListeners();
  }

  set estado(String value) {
    _estado = value;
    notifyListeners();
  }

  set cep(String value) {
    _cep = value;
    notifyListeners();
  }

  set dataNascimento(String value) {
    _dataNascimento = value;
    notifyListeners();
  }

  set cpf(String value) {
    _cpf = value;
    notifyListeners();
  }

  set telefone(String value) {
    _telefone = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set nome(String value) {
    _nome = value;
    notifyListeners();
  }

  // Tela de Cadastro de Cliente
  int _stepAtual = 0;

  int get stepAtual => _stepAtual;

  set stepAtual(int value) {
    _stepAtual = value;
    notifyListeners();
  }
}
