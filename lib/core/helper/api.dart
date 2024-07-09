import 'dart:convert';
import 'dart:io';

import 'package:elysia/core/config/api.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  final http.Client client = http.Client();

  Future<T> getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
    Map<String, String>? header,
  }) async {
    try {
      final response = await client.get(
        uri,
        headers: header,
      );

      print(response.body);
      print(response.statusCode);
      switch (response.statusCode) {
        case HttpStatus.ok:
          final data = jsonDecode(response.body);
          return builder(data);
        case HttpStatus.notFound:
          throw Exception("endpoint not found");
        default:
          final data = jsonDecode(response.body);
          throw Exception(data.toString());
      }
    } on SocketException catch (_) {
      throw Exception("No Internet Connection");
    }
  }

  Future<T> postData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
    Map<String, String>? header,
    Map<String, dynamic>? jsonBody,
  }) async {
    try {
      final response = await client.post(
        uri,
        headers: header,
        body: jsonEncode(jsonBody),
      );

      print(response.body);
      print(response.statusCode);
      switch (response.statusCode) {
        case HttpStatus.ok:
          final data = jsonDecode(response.body);
          return builder(data);
        case HttpStatus.created:
          final data = jsonDecode(response.body);
          return builder(data);
        case HttpStatus.unprocessableEntity:
          final data = jsonDecode(response.body);
          throw Exception(data["message"]);
        case HttpStatus.notFound:
          throw Exception("endpoint not found");
        default:
          final data = jsonDecode(response.body);
          throw Exception(data.toString());
      }
    } on SocketException catch (_) {
      throw Exception("No Internet Connection");
    }
  }

  static Uri buildUri({
    required String endpoint,
    Map<String, String>? params,
  }) {
    var uri = Uri(
      scheme: "https",
      host: ApiConfig.baseUrl,
      path: endpoint,
      queryParameters: params,
    );

    return uri;
  }

  static Map<String, String> header() {
    return {
      "content-type": "application/json",
    };
  }
}
