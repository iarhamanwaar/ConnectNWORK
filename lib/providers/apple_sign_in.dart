import 'package:connectnwork/constants.dart';
import 'package:connectnwork/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSign {
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
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      final result = await SignInWithApple.getAppleIDCredential(
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: '${packageInfo.packageName}.applesignin',
          redirectUri: Uri.parse(
            appleSignInRedirectURI!,
          ),
        ),
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final credential = OAuthProvider('apple.com').credential(
        accessToken: result.authorizationCode,
        idToken: result.identityToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseException catch (e) {
      Utils.showSnackbar(e.message);
    } on SignInWithAppleAuthorizationException catch (e) {
      Utils.showSnackbar(e.message);
    }

    navigatorKey.currentState!.pop();
  }
}
