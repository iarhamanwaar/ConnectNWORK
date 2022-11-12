import 'package:connectnwork/constants.dart';
import 'package:connectnwork/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSign {
  static Future login() async {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.accessToken != null) {
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(
          loginResult.accessToken!.token,
        );

        await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      }
    } on FirebaseException catch (e) {
      Utils.showSnackbar(e.message);
    }

    navigatorKey.currentState!.pop();
  }
}
