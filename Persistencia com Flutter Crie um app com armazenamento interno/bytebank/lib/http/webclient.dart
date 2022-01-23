import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';

Future<List<Transaction>> findAll() async {
  Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  final List<Transaction> transactions = [];
  final Uri url = Uri.parse('http://192.168.15.10:8080/transactions');
  final Response response =
      await client.get(url).timeout(const Duration(seconds: 5));
  final List<dynamic> data = jsonDecode(response.body);

  for (Map<String, dynamic> element in data) {
    Contact contact = Contact(
        id: 0,
        name: element['contact']['name'],
        accountNumber: element['contact']['accountNumber']);

    final Transaction tr = Transaction(element['value'], contact);
    transactions.add(tr);
  }
  print(transactions.toString());
  return transactions;
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // print(data.toString());
    return data;
  }
}
