import 'package:connectnwork/constants.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/drawer.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:connectnwork/widgets/unverified_drawer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  bool verified = false;

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);

    if (myProfile!.idVerified != null && myProfile!.idVerified == true) {
      verified = true;
    }

    return ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: verified ? const CustomDrawer() : const UnverifiedDrawer(),
        appBar: const CustomAppBar(
          title: 'Support',
          drawer: true,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: kBluePrimary,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF000000).withOpacity(0.05),
                          blurRadius: 30,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 32.0,
                        right: 32.0,
                        top: 20.0,
                        bottom: 38.0,
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 3,
                            color: Colors.black,
                          ),
                          text: 'Do you have a problem while using the app? Please email us at ',
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await launchUrl(
                                    Uri(
                                      scheme: 'mailto',
                                      path: 'info@connectnwork.com',
                                    ),
                                  );
                                },
                              text: 'info@connectnwork.com',
                              style: const TextStyle(
                                color: kBluePrimary,
                              ),
                            ),
                            const TextSpan(
                              text: ' or call / text our support team at ',
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await launchUrl(
                                    Uri(
                                      scheme: 'tel',
                                      path: '(438) 540 - 5230',
                                    ),
                                  );
                                },
                              text: '(438) 540 - 5230',
                              style: const TextStyle(
                                color: kBluePrimary,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
