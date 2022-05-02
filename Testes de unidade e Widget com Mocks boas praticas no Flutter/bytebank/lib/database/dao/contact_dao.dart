import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

class ContactDAO {
  static const tableName = "contacts";
  static const _id = "id";
  static const _name = "name";
  static const _accountNumber = "account_number";

  static const String tableSQL = "CREATE TABLE $tableName ( "
      "$_id INTEGER PRIMARY KEY, "
      "$_name TEXT, "
      "$_accountNumber INTEGER "
      ")";

  Future<int> save(Contact contact) async {
    final Database db = await createDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);

    return db.insert(tableName, contactMap);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> rows = await db.query(tableName);
    final List<Contact> contacts = [];

    return _toList(rows, contacts);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  List<Contact> _toList(List<Map<String, dynamic>> rows, List<Contact> contacts) {
    for (Map<String, dynamic> row in rows) {
      final Contact contact = Contact(
        id: row[_id],
        name: row[_name],
        accountNumber: row[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
