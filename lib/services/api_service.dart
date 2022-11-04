import 'dart:convert';

import 'package:connectnwork/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

mixin APIService {
  static final baseUrl = server;

  static Future<http.Response> get({
    required String endpoint,
  }) async {
    http.Response response;

    try {
      response = await http.get(
        Uri.parse(
          '$baseUrl$endpoint',
        ),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } on Exception {
      throw 'Exception thrown from get API with path: $endpoint';
    }
  }

  static Future<http.Response> getWithAuth({
    required String endpoint,
  }) async {
    String token = await FirebaseAuth.instance.currentUser!.getIdToken();

    if (token.length > 950) {
      print('token.length = ${token.length}');
      int chunkCount = token.length ~/ 950;
      for (int i = 0; i <= chunkCount; i++) {
        int max = 950 * (i + 1);
        if (max >= token.length) {
          print('chunk $i of $chunkCount: ${token.substring(950 * i)}');
        } else {
          print('chunk $i of $chunkCount: ${token.substring(950 * i, max)}');
        }
      }
    } else {
      print(token);
    }

    http.Response response;

    try {
      response = await http.get(
        Uri.parse(
          '$baseUrl$endpoint',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } on Exception {
      throw 'Exception thrown from getWithAuth API with path: $endpoint';
    }
  }

  static Future<http.Response> deleteWithAuth({
    required String endpoint,
  }) async {
    String token = await FirebaseAuth.instance.currentUser!.getIdToken();

    http.Response response;

    try {
      response = await http.delete(
        Uri.parse(
          '$baseUrl$endpoint',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } on Exception {
      throw 'Exception thrown from deleteWithAuth API with path: $endpoint';
    }
  }

  static Future<http.Response> patchWithAuth({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    String token = await FirebaseAuth.instance.currentUser!.getIdToken();

    http.Response response;

    try {
      String encoded = json.encode(body);
      response = await http.patch(
        Uri.parse(
          '$baseUrl$endpoint',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: encoded,
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } on Exception {
      throw 'Exception thrown from patchWithAuth API with path: $endpoint';
    }
  }

  static Future<http.Response> postWithAuth({
    required String endpoint,
    required var body,
  }) async {
    String token = await FirebaseAuth.instance.currentUser!.getIdToken();

    http.Response response;

    try {
      if (body != null) {
        response = await http.post(
          Uri.parse(
            '$baseUrl$endpoint',
          ),
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: body,
        );
      } else {
        response = await http.post(
          Uri.parse(
            '$baseUrl$endpoint',
          ),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
      }

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } on Exception {
      throw 'Exception thrown from postWithAuth API with path: $endpoint';
    }
  }
}
