import 'package:connectnwork/constants.dart';
import 'package:connectnwork/dialogs/address_verification_dialog.dart';
import 'package:connectnwork/repos/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showIdCompletionDialog() async {
  return showDialog(
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(40, 18, 40, 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Congratulations!\nYour profil is now completed. We will be back to you soon if all requirements are provided.',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          navigatorKey.currentState!.pop();
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: const BorderSide(
                              color: kBluePrimary,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 10.0,
                          ),
                          child: Center(
                            child: Text(
                              'Close',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: kBluePrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
