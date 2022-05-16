import 'package:flutter/material.dart';

showAlert({context, title, content}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Atenção'),
        content: Text(
            'CPF ou senha inválidos.\n\nA Senha precisa ter mais de 8 caracteres e conter ao menos uma letra maiúscula, um algarismo e um caractere especial'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}
