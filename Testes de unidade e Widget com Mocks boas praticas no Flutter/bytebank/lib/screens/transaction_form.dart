import 'dart:async';

import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/widgets/app_dependecies.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm(this.contact, {Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = const Uuid().v4();

  bool _isSending = false;

  void _save(Transaction tr, String password, BuildContext context,
      TransactionWebClient webClient) async {
    Transaction transaction = await _send(webClient, tr, password, context);
    _showSuccessfulMessage(transaction, context);
  }

  Future<void> _showSuccessfulMessage(
      Transaction transaction, BuildContext context) async {
    await showDialog(
        context: context,
        builder: (contextDialog) {
          return const SuccessDialog('successful transaction');
        });
    Navigator.pop(context);
  }

  Future<Transaction> _send(TransactionWebClient webClient, Transaction tr,
      String password, BuildContext context) async {
    setState(() => _isSending = true);
    final Transaction transaction = await webClient
        .save(tr, password)
        .catchError((e) {
      _showFailureMessage(context, e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailureMessage(context, "Timeout exception");
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureMessage(context, "Unknown Error");
    }, test: (e) => e is Exception).whenComplete(
            () => setState(() => _isSending = false));
    return transaction;
  }

  void _showFailureMessage(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _isSending,
                child: const Progress(
                  message: "Sending Transfer...",
                ),
              ),
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Transfer'),
                    onPressed: () {
                      final double value = double.parse(_valueController.text);
                      final transaction =
                          Transaction(transactionId, value, widget.contact);
                      showDialog(
                          context: context,
                          builder: (ctxDialog) => TransactionAuthDialog(
                                onConfirm: (String password) {
                                  _save(transaction, password, ctxDialog,
                                      dependencies.webClient);
                                  Navigator.pop(context);
                                },
                              ));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
