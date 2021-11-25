import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const database = "contacts";

Future<Database> createDatabase() async {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute("CREATE TABLE contacts ( "
          "'id' INTEGER PRIMARY KEY, "
          "'name' TEXT, "
          "'account_number' INTEGER "
          ")");
    }, version: 1);
  });
}

Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = {};
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;

    return db.insert(database, contactMap);
  });
}

Future<List<Contact>> findAll() async {
  return createDatabase().then((db) {
    return db.query(database).then((maps) {
      final List<Contact> contacts = [];
      for (Map<String, dynamic> map in maps) {
        final Contact contact = Contact(
          id: map['id'],
          name: map['name'],
          accountNumber: map['account_number'],
        );
        contacts.add(contact);
      }
      return contacts;
    });
  });
}
