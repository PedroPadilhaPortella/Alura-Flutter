import 'dart:convert';
import 'package:bytebank/http/webclient.dart';
import 'package:http/http.dart';
import 'package:bytebank/models/transaction.dart';

class TransactionWebClient {
  final Uri url = Uri.parse('http://192.168.15.10:8080/transactions');

  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(url).timeout(const Duration(seconds: 5));

    final List<dynamic> data = jsonDecode(response.body);

    return _toTransactions(data);
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(url,
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transactionJson);

    Map<String, dynamic> json = jsonDecode(response.body);
    return _toTransaction(json);
  }

  Transaction _toTransaction(Map<String, dynamic> json) {
    return Transaction.fromJson(json);
  }

  List<Transaction> _toTransactions(List<dynamic> data) {
    return data
        .map((dynamic element) => Transaction.fromJson(element))
        .toList();
  }
}
