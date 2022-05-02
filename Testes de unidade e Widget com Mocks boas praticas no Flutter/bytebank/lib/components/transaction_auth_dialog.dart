import 'package:flutter/material.dart';

const Key transactionAuthDialogPassword =
    Key('TransactionAuthDialogTextFieldPassword');

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  const TransactionAuthDialog({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Autenticate"),
      content: TextField(
        key: transactionAuthDialogPassword,
        controller: _passwordController,
        obscureText: true,
        keyboardType: TextInputType.number,
        maxLength: 4,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 64, letterSpacing: 24),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              widget.onConfirm(_passwordController.text);
              Navigator.pop(context);
            },
            child: const Text("Confirmar")),
      ],
    );
  }
}
