import 'package:connectnwork/models/my_profile_model.dart';
import 'package:connectnwork/services/api_service.dart';

class UserRepository {
  static Future<MyProfile> get() async {
    try {
      final response = await APIService.getWithAuth(
        endpoint: '/api/user/profile',
      );

      return myProfileFromJson(response.body);
    } catch (e) {
      throw 'Exception thrown from UserRepository while getting user profile.';
    }
  }

  static Future<MyProfile> verify() async {
    try {
      final response = await APIService.postWithAuth(
        endpoint: '/api/employee/identity/verify',
      );

      return myProfileFromJson(response.body);
    } catch (e) {
      throw 'Exception thrown from UserRepository while posting certn details.';
    }
  }
}
