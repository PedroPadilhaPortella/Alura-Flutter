import 'package:bytebank/models/contact.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('When a Contact is created', () {
    test('should return the value of the contact', () {
      final contact = Contact(id: 1, name: 'Pedro', accountNumber: 12345);
      expect(contact.toString(),
          'Contact {id: 1, name: Pedro, accountNumber: 12345}');
    });

    test('should convert a json data to a contact', () {
      final json = {'name': 'Pedro', 'accountNumber': 12345};
      final contact = Contact.fromJson(json);

      expect(contact.id, 0);
      expect(contact.name, 'Pedro');
      expect(contact.accountNumber, 12345);
    });

    test('should convert a contact to a json data', () {
      final contact = Contact(id: 1, name: 'Pedro', accountNumber: 12345);
      final json = contact.toJson();

      expect(json['name'], 'Pedro');
      expect(json['accountNumber'], 12345);
    });
  });
}
