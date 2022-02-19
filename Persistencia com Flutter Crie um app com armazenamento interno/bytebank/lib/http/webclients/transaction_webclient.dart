import 'dart:convert';
import 'package:bytebank/http/webclient.dart';
import 'package:http/http.dart';
import 'package:bytebank/models/transaction.dart';

class TransactionWebClient {
  final Uri url = Uri.parse('http://192.168.15.10:8080/transactions');

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed'
  };

  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(url);

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

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return _toTransaction(json);
    }

    // _throwHttpError(response.statusCode);
    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  Transaction _toTransaction(Map<String, dynamic> json) {
    return Transaction.fromJson(json);
  }

  List<Transaction> _toTransactions(List<dynamic> data) {
    return data
        .map((dynamic element) => Transaction.fromJson(element))
        .toList();
  }

  // void _throwHttpError(int statusCode) =>
  //     throw Exception(_statusCodeResponses[statusCode]);
}

class HttpException implements Exception {
  final String? message;

  HttpException(this.message);
}
