import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';

Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);

final Uri url = Uri.parse('http://192.168.15.10:8080/transactions');

Future<List<Transaction>> findAll() async {
  final List<Transaction> transactions = [];
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
  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber
    }
  };
  final String transactionJson = jsonEncode(transactionMap);

  final Response response = await client.post(url,
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transactionJson);

  Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(
    json['value'],
    Contact(
      id: 0,
      name: contactJson['name'],
      accountNumber: contactJson['accountNumber'],
    ),
  );
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
