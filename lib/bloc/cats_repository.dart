import 'dart:convert';
import 'dart:io';

import 'cat.dart';
import 'package:http/http.dart' as http;

abstract class CatsRepository {
  Future<List<Cat>> getCats();
}

class SampleCatsRepository implements CatsRepository {
  final baseUrl = "https://hwasampleapi.firebaseio.com/http.json";
  @override
  Future<List<Cat>> getCats() async {
    final response = await http.get(baseUrl);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = jsonDecode(response.body) as List;
        return jsonBody.map((e) => Cat.fromJson(e)).toList();
      default:
        throw NetworkError(response.statusCode.toString(), response.body);
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;

  NetworkError(this.statusCode, this.message);
}
