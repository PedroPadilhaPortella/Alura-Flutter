import 'dart:async';
import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/error.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class TransactionFormState {
  const TransactionFormState();
}

@immutable
class ShowFormState extends TransactionFormState {
  const ShowFormState();
}

@immutable
class SendingState extends TransactionFormState {
  const SendingState();
}

@immutable
class SentState extends TransactionFormState {
  const SentState();
}

@immutable
class FatalErrorState extends TransactionFormState {
  final String message;
  const FatalErrorState({required this.message});
}

class TransactionFormContainer extends BlocContainer {
  final Contact _contact;
  const TransactionFormContainer(this._contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
      create: (BuildContext context) {
        return TransactionFormCubit();
      },
      child: BlocListener<TransactionFormCubit, TransactionFormState>(
        child: TransactionForm(contact: _contact),
        listener: (context, state) {
          if (state is SentState) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

class TransactionFormCubit extends Cubit<TransactionFormState> {
  final TransactionWebClient webClient = TransactionWebClient();

  TransactionFormCubit() : super(const ShowFormState());

  void save(Transaction tr, String password, BuildContext context) async {
    emit(const SendingState());
    _send(tr, password, context);
  }

  void _send(Transaction tr, String password, BuildContext context) async {
    await webClient
        .save(tr, password)
        .then((transaction) => emit(const SentState()))
        .catchError((e) {
      emit(FatalErrorState(message: e.toString()));
    }, test: (e) => e is HttpException).catchError((e) {
      emit(const FatalErrorState(message: "Timeout exception"));
    }, test: (e) => e is TimeoutException).catchError((e) {
      emit(const FatalErrorState(message: "Unknown Error"));
    });
  }
}

class TransactionForm extends StatelessWidget {
  final Contact contact;

  const TransactionForm({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
        builder: ((context, state) {
      if (state is ShowFormState) {
        return BasicForm(contact: contact);
      }
      if (state is SendingState || state is SentState) {
        return const ProgressView(
          title: "Saving Tranfer",
          message: "Saving Tranfer",
        );
      }
      if (state is FatalErrorState) {
        return ErrorView(state.message);
      }
      return const ErrorView("Unknown error");
    }));
  }
}

class BasicForm extends StatelessWidget {
  final Contact contact;
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = const Uuid().v4();

  BasicForm({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New transaction')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  contact.accountNumber.toString(),
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
                          Transaction(transactionId, value, contact);
                      showDialog(
                        context: context,
                        builder: (ctxDialog) => TransactionAuthDialog(
                          onConfirm: (String password) {
                            BlocProvider.of<TransactionFormCubit>(context)
                                .save(transaction, password, ctxDialog);
                            Navigator.pop(context);
                          },
                        ),
                      );
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
