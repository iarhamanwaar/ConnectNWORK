import 'package:connectnwork/models/job_model.dart';
import 'package:connectnwork/services/api_service.dart';

class JobsRepository {
  static Future<List<Job>> get() async {
    try {
      final response = await APIService.getWithAuth(
        endpoint: '/api/jobs/browse',
      );

      return jobFromJson(response.body);
    } catch (e) {
      throw 'Exception thrown from UserRepository while getting user profile.';
    }
  }
}
