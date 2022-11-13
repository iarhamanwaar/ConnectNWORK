import 'package:connectnwork/models/earnings_model.dart';
import 'package:connectnwork/models/employee_job_model.dart' as ej;
import 'package:connectnwork/models/job_model.dart';
import 'package:connectnwork/services/api_service.dart';
import 'package:flutter/foundation.dart';

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
      if (kDebugMode) {
        print('Exception thrown from JobsRepository while getting user jobs, error: $e');
      }
      throw 'Exception thrown from JobsRepository while getting user jobs, error: $e';
    }
  }

  static Future<void> apply({
    required String jobId,
  }) async {
    try {
      await APIService.postWithAuth(
        endpoint: '/api/employee/job/apply/$jobId',
        body: null,
      );
    } catch (e) {
      throw 'Exception thrown from JobsRepository while applying for job.';
    }
  }

  static Future<void> cancel({
    required String jobId,
    required String cancelReason,
  }) async {
    Map<String, dynamic> body = {
      "cancelReason": cancelReason,
    };

    try {
      await APIService.postWithAuth(
        endpoint: '/api/employee/job/cancel/$jobId',
        body: body,
      );
    } catch (e) {
      throw 'Exception thrown from JobsRepository while applying for job.';
    }
  }

  static Future<List<Earnings>?> getEarnings({String period = '', String startDate = '', String endDate = ''}) async {
    try {
      String endpoint = '/api/employee/earnings';

      if (period != '' && startDate == '' && endDate == '') {
        endpoint += '?period=$period';
      } else if (startDate != '' && endDate != '' && period == '') {
        endpoint += '?startDate=$startDate&endDate=$endDate';
      } else if (startDate != '' && period == '') {
        endpoint += '?startDate=$startDate';
      } else if (endDate != '' && period == '') {
        endpoint += '?endDate=$endDate';
      }

      final response = await APIService.getWithAuth(
        endpoint: endpoint,
      );

      if (response.body == '[]') {
        return null;
      }

      return earningsFromJson(response.body);
    } catch (e) {
      throw 'Exception thrown from JobsRepository while getting earnings.';
    }
  }
}
