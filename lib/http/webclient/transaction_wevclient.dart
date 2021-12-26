import 'dart:convert';

import 'package:new_byte_bank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:new_byte_bank/http/interceptors/logging_interceptor.dart';
import 'package:new_byte_bank/models/contact.dart';

class TransactionWebClient {
  final String baseUrl = '527d-187-109-155-79.ngrok.io';

  Future<List<Transaction>> findAll() async {
    Client client =
        InterceptedClient.build(interceptors: [LoggingInterceptor()]);

    final Response response = await client.get(
      Uri.http(
        baseUrl,
        'transactions',
      ),
    );

    final List<dynamic> decodedJson = jsonDecode(response.body);

    final List<Transaction> transactions = [];

    for (Map<String, dynamic> transactionJson in decodedJson) {
      final Map<String, dynamic> contactJson = transactionJson['contact'];

      final Transaction transaction = Transaction(
        transactionJson['value'],
        Contact(
          0,
          contactJson['name'],
          contactJson['accountNumber'],
        ),
      );

      transactions.add(transaction);
    }

    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    Client client =
        InterceptedClient.build(interceptors: [LoggingInterceptor()]);
    final Map<String, dynamic> transactionMap = {
      "value": transaction.value,
      "contact": {
        "name": transaction.contact.name,
        "accountNumber": transaction.contact.accountNummber,
      }
    };

    final String transactionJson = jsonEncode(transactionMap);

    final Response response = await client.post(
        Uri.http(
          baseUrl,
          'transactions',
        ),
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJson);

    Map<String, dynamic> json = jsonDecode(response.body);

    final Map<String, dynamic> contactJson = json['contact'];
    return Transaction(
      json['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
  }
}
