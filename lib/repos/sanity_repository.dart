import 'package:http/http.dart' as http;

class SanityRepository {
  static const projectId = '7d3rcta7';
  static const dataset = 'production';

  static Future<String> get({
    required String query,
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{'query': query};

    final uri = Uri(
      scheme: 'https',
      host: '$projectId.apicdn.sanity.io',
      path: '/v1/data/query/$dataset',
      queryParameters: queryParameters,
    );

    http.Response response;

    try {
      response = await http.get(uri);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } on Exception {
      throw 'Exception thrown from get SanityRepository with query: $query';
    }
  }
}
