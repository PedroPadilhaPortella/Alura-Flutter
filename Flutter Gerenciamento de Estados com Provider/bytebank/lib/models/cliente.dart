import 'dart:io';

import 'package:flutter/material.dart';

class Cliente extends ChangeNotifier {
  String _nome = '';
  String _email = '';
  String _telefone = '';
  String _cpf = '';
  String _dataNascimento = '';
  String _cep = '';
  String _estado = '';
  String _cidade = '';
  String _bairro = '';
  String _logradouro = '';
  String _numero = '';
  String _senha = '';

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
  File? _imageRG;
  bool _biometria = false;

  int get stepAtual => _stepAtual;

  File? get imageRG => _imageRG;

  bool get biometria => _biometria;

  set stepAtual(int value) {
    _stepAtual = value;
    notifyListeners();
  }

  set imageRG(File? value) {
    _imageRG = value;
    notifyListeners();
  }

  set biometria(bool value) {
    _biometria = value;
    notifyListeners();
  }
}
