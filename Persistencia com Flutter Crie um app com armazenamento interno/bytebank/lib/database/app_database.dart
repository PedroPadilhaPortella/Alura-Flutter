import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const database = "contacts";

Future<Database> createDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute("CREATE TABLE contacts ( "
          "'id' INTEGER PRIMARY KEY, "
          "'name' TEXT, "
          "'account_number' INTEGER "
          ")");
    },
    version: 1,
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}

Future<int> save(Contact contact) async {
  final Database db = await createDatabase();
  final Map<String, dynamic> contactMap = {};
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;

  return db.insert(database, contactMap);
}

Future<List<Contact>> findAll() async {
  final Database db = await createDatabase();
  final List<Map<String, dynamic>> rows = await db.query(database);
  final List<Contact> contacts = [];

  for (Map<String, dynamic> row in rows) {
    final Contact contact = Contact(
      id: row['id'],
      name: row['name'],
      accountNumber: row['account_number'],
    );
    contacts.add(contact);
  }
  return contacts;
}
