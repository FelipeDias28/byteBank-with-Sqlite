import 'package:new_byte_bank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNmber INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _accountNmber = 'account_number';
  static const String _name = 'name';

  // Função para salvar o contato
  Future<int> save(Contact contact) async {
    final Database db = await createDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);

    return db.insert(_tableName, contactMap);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};

    contactMap[_name] = contact.name;
    contactMap[_accountNmber] = contact.accountNummber;
    return contactMap;
  }

// Função para buscar todos os contatos
  Future<List<Contact>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contacts = _toList(result);

    return contacts;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];

    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_id],
        row[_name],
        row[_accountNmber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
