import 'package:flutter/material.dart';
import 'package:new_byte_bank/database/app_database.dart';
import 'package:new_byte_bank/models/contact.dart';
import 'package:new_byte_bank/screens/contact_form.dart';
import 'package:new_byte_bank/screens/contacts_list.dart';
import 'package:new_byte_bank/screens/dashoard.dart';

void main() {
  runApp(BytebankApp());
  save(Contact(0, 'Alex', 10000)).then((id) {
    findAll().then((contacts) => debugPrint(contacts.toString()));
  });
}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green.shade900,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green.shade900,
          secondary: Colors.blueAccent.shade700,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blueAccent.shade700),
          ),
        ),
      ),
      home: const Dashboard(),
    );
  }
}
