import 'package:connectnwork/models/iaddress_schema.dart';
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

  static Future<void> update({
    String? firstName,
    String? lastName,
    IAddressSchema? address,
    bool? notification,
    DateTime? dob,
    String? locale,
    String? picture,
    String? type,
    String? resume,
    String? workPermit,
    String? phoneNumber,
    String? interac,
    String? bio,
    String? ssn,
    bool? suspended,
  }) async {
    Map<String, dynamic> body = {
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (address != null) "address": address,
      if (notification != null) "notification": notification.toString(),
      if (dob != null) "dob": dob.toString(),
      if (locale != null) "locale": locale,
      if (picture != null) "picture": picture,
      if (type != null) "type": type,
      if (resume != null) "resume": resume,
      if (workPermit != null) "workPermit": workPermit,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (interac != null) "interac": interac,
      if (bio != null) "bio": bio,
      if (ssn != null) "ssn": ssn,
      if (suspended != null) "suspended": suspended.toString(),
    };

    try {
      await APIService.patchWithAuth(
        endpoint: '/api/user/profile',
        body: body,
      );

      return;
    } catch (e) {
      throw 'Exception thrown from UserRepository while updating user profile. Error: $e';
    }
  }

  // static Future<MyProfile> verify() async {
  //   var body;
  //   try {
  //     final response = await APIService.postWithAuth(
  //       endpoint: '/api/employee/identity/verify',
  //       body: body,
  //     );
  //
  //     return myProfileFromJson(response.body);
  //   } catch (e) {
  //     throw 'Exception thrown from UserRepository while posting certn details.';
  //   }
  // }
}
