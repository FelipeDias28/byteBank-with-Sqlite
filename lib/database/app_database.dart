import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabase() {
  // função do sqflite
  getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');

    // Função que vai abrir o banco de dados
    openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
    }, version: 1);
  });
}
