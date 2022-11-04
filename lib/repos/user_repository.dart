import 'dart:io';

import 'package:connectnwork/models/iaddress_schema.dart';
import 'package:connectnwork/models/my_profile_model.dart';
import 'package:connectnwork/models/notification_model.dart';
import 'package:connectnwork/services/api_service.dart';
import 'package:flutter/foundation.dart';

class UserRepository {
  static Future<MyProfile> get() async {
    try {
      final response = await APIService.getWithAuth(
        endpoint: '/api/user/profile',
      );

      return myProfileFromJson(response.body);
    } catch (e) {
      if (kDebugMode) {
        print('Exception thrown from UserRepository while getting user profile, error: $e');
      }
      throw 'Exception thrown from UserRepository while getting user profile.';
    }
  }

  static Future<List<Notification>?> getNotifcations() async {
    try {
      final response = await APIService.getWithAuth(
        endpoint: '/api/notification/employee',
      );

      if (response.body == '[]') {
        return null;
      }

      return notificationFromJson(response.body);
    } catch (e) {
      if (kDebugMode) {
        print('Exception thrown from UserRepository while getting notifications, error: $e');
      }
      throw 'Exception thrown from UserRepository while getting notifications, error: $e';
    }
  }

  static Future<void> deleteNotifcation({required String id}) async {
    try {
      await APIService.deleteWithAuth(
        endpoint: '/api/notification/$id',
      );

      return;
    } catch (e) {
      if (kDebugMode) {
        print('Exception thrown from UserRepository while deleting notification, error: $e');
      }
      throw 'Exception thrown from UserRepository while deleting notification, error: $e';
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
    String? deviceId,
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
      if (deviceId != null) "deviceIds": deviceId,
    };

    try {
      await APIService.patchWithAuth(
        endpoint: '/api/user/profile',
        body: body,
      );
    } catch (e) {
      throw 'Exception thrown from UserRepository while updating user profile. Error: $e';
    }
  }

  static Future<void> verify({
    String? idFrontSideImgBase64,
    String? idBackSideImgBase64,
    String? faceImgBase64,
    String? idType,
    String? idCountryCode,
  }) async {
    String? iIdType;
    if (idType != null) {
      if (idType == 'Passport') {
        iIdType = 'PASSPORT';
      } else if (idType == 'Driving License') {
        iIdType = 'DRIVING_LICENSE';
      } else if (idType == 'ID Card') {
        iIdType = 'ID_CARD';
      } else if (idType == 'Visa') {
        iIdType = 'VISA';
      }
    }

    Map<String, dynamic> body = {
      if (idFrontSideImgBase64 != null) "idFrontSideImgBase64": idFrontSideImgBase64,
      if (idBackSideImgBase64 != null) "idBackSideImgBase64": idBackSideImgBase64,
      if (faceImgBase64 != null) "faceImgBase64": faceImgBase64,
      if (iIdType != null) "idType": iIdType,
      if (idCountryCode != null) "idCountryCode": idCountryCode,
    };

    try {
      final response = await APIService.postWithAuth(
        endpoint: '/api/employee/identity/verify',
        body: body,
      );

      print(response.body);
    } catch (e) {
      throw 'Exception thrown from UserRepository while posting certn details.';
    }
  }
}
