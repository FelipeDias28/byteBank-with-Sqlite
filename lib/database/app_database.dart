import 'package:new_byte_bank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  // função do sqflite
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');

    // Função que vai abrir o banco de dados
    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
    }, version: 1);
  });
}

// Função para salvar o contato
Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = {};

    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNummber;

    return db.insert('contacts', contactMap);
  });
}

// Função para buscar todosos contatos
Future<List<Contact>> findAll() {
  return createDatabase().then((db) {
    return db.query('contacts').then((maps) {
      final List<Contact> contacts = [];
      for (Map<String, dynamic> map in maps) {
        final Contact contact = Contact(
          map['id'],
          map['name'],
          map['account_number'],
        );
        contacts.add(contact);
      }

      return contacts;
    });
  });
}
