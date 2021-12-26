import 'package:flutter/material.dart';
import 'package:new_byte_bank/models/transaction.dart';

import 'package:new_byte_bank/screens/dashoard.dart';

import 'models/contact.dart';

void main() {
  runApp(const BytebankApp());
  // // save(Transaction(20000, Contact(0, "Gui", 2000)))
  // //     .then((transaction) => print(transaction));
  // findAll().then((transactions) => print('new transaction: $transactions'));
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

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
