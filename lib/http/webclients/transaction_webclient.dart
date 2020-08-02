import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {

    await Future.delayed(Duration(seconds: 10));

    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client
        .post(baseUrl,
            headers: {'Content-type': 'application/json', 'password': password},
            body: transactionJson)
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    print('status code: $statusCode');
    if(_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    } else {
      return 'Unknown error';
    }

  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction already exists',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
