import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:new_byte_bank/models/contact.dart';
import 'package:new_byte_bank/models/transaction.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('Request: ');
    print('url ${data.url}');
    print('headers ${data.headers}');
    print('body ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}

Future<List<Transaction>> findAll() async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  final Response response = await client.get(
    Uri.http(
      'bb63-189-34-156-251.ngrok.io',
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
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Map<String, dynamic> transactionMap = {
    "value": transaction.value,
    "contact": {
      "name": transaction.contact.name,
      "accountNumber": transaction.contact.accountNummber,
    }
  };

  final String transactionJson = jsonEncode(transactionMap);

  // final Response response = await client.post(
  //   Uri.http(
  //       'bb63-189-34-156-251.ngrok.io',
  //       'transactions',
  //       {
  //         'Content-type': 'application/josn',
  //         "password": "1000",
  //       },
  //       transactionJson),
  // );

  final Response response = await client.post(
      Uri.http(
        'bb63-189-34-156-251.ngrok.io',
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
