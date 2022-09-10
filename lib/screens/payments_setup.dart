import 'package:connectnwork/constants.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentsSetupScreen extends StatefulWidget {
  const PaymentsSetupScreen({Key? key}) : super(key: key);

  @override
  State<PaymentsSetupScreen> createState() => _PaymentsSetupScreenState();
}

class _PaymentsSetupScreenState extends State<PaymentsSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          title: 'Payments Setup',
          drawer: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 45),
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                        ),
                        child: Text(
                          'Enter your email or phone number that will allow you to receive your payment deposit with Interac.',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 70.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 34.0,
                                    vertical: 9.0,
                                  ),
                                  hintText: 'corrababi@gmail.com',
                                ),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                        ),
                        child: Text(
                          'Enter your Social Insurance Number to make sure you are allowed to work legally in Canada',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 70.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 34.0,
                                    vertical: 9.0,
                                  ),
                                  hintText: '*** - *** - ***',
                                ),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                        ),
                        child: Text(
                          'All your information will be kept private and secure.',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(kBluePrimary),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          child: Text(
                            'Send',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
