import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> createDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDAO.tableSQL);
    },
    version: 1,
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}

