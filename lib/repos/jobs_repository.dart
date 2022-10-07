import 'package:connectnwork/models/employee_job_model.dart' as ej;
import 'package:connectnwork/models/job_model.dart';
import 'package:connectnwork/services/api_service.dart';

class JobsRepository {
  static Future<List<Job>?> browse() async {
    try {
      final response = await APIService.getWithAuth(
        endpoint: '/api/jobs/browse',
      );

      if (response.body == '[]') {
        return null;
      }

      return jobFromJson(response.body);
    } catch (e) {
      throw 'Exception thrown from JobsRepository while browsing jobs.';
    }
  }

  static Future<List<ej.EmployeeJob>?> get({String status = ''}) async {
    try {
      final response = await APIService.getWithAuth(
        endpoint: '/api/employee/job${status != '' ? '?status=$status' : ''}',
      );

      if (response.body == '[]') {
        return null;
      }

      return ej.employeeJobFromJson(response.body);
    } catch (e) {
      throw 'Exception thrown from JobsRepository while getting user jobs.';
    }
  }
}
