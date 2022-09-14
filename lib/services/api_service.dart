import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

mixin APIService {
  static const devUrl = 'https://dev-api.connectnwork.com';

  static const baseUrl = devUrl;

  static Future<http.Response> getWithAuth({
    required String endpoint,
  }) async {
    String token = await FirebaseAuth.instance.currentUser!.getIdToken();
    print(token);

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

  static Future<http.Response> postWithAuth({
    required String endpoint,
  }) async {
    String token = await FirebaseAuth.instance.currentUser!.getIdToken();

    http.Response response;

    try {
      response = await http.post(
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
      throw 'Exception thrown from postWithAuth API with path: $endpoint';
    }
  }
}
