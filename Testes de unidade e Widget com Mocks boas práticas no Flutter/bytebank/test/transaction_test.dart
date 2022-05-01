import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('When a Transaction is created', () {
    test('should return the value of the transaction', () {
      final contact = Contact(id: 1, name: 'Pedro', accountNumber: 12345);
      final transaction = Transaction('1', 100, contact);

      expect(transaction.value, 100);
      expect(transaction.toString(),
          'Transaction {value: 100.0, contact: Contact {id: 1, name: Pedro, accountNumber: 12345}}');
    });

    test('should display error when the value be less than 0', () {
      final contact = Contact(id: 1, name: 'Pedro', accountNumber: 12345);

      expect(() => Transaction('1', -1, contact), throwsAssertionError);
    });

    test('should convert a json data to a transaction', () {
      final json = {
        'id': '1',
        'value': 100.0,
        'contact': {'name': 'Pedro', 'accountNumber': 12345}
      };

      final transaction = Transaction.fromJson(json);

      expect(transaction.id, '1');
      expect(transaction.value, 100.0);
      expect(transaction.contact.id, 0);
      expect(transaction.contact.name, 'Pedro');
      expect(transaction.contact.accountNumber, 12345);
    });

    test('should convert a transaction to a json data', () {
      final contact = Contact(id: 1, name: 'Pedro', accountNumber: 12345);
      final transaction = Transaction('1', 100, contact);

      final json = transaction.toJson();

      expect(json['id'], '1');
      expect(json['value'], 100);
      expect(json['contact']['name'], 'Pedro');
      expect(json['contact']['accountNumber'], 12345);
    });
  });
}
