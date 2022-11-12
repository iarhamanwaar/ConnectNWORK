import 'package:connectnwork/constants.dart';
import 'package:connectnwork/repos/user_repository.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _interacController = TextEditingController();
  final TextEditingController _socialSecurityController = TextEditingController();
  bool sent = false;

  @override
  void initState() {
    if (myProfile!.interac != null) {
      _interacController.text = myProfile!.interac!;
    }

    if (myProfile!.ssn != null) {
      _socialSecurityController.text = myProfile!.ssn!;
    }

    super.initState();
  }

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
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                                  child: TextFormField(
                                    controller: _interacController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: const OutlineInputBorder(),
                                      contentPadding: const EdgeInsets.symmetric(
                                        vertical: 9.0,
                                      ),
                                      hintText: 'abc@email.com',
                                      hintStyle: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF77838F),
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: false,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                          r"{0,253}[a-zA-Z0-9])?)*$";
                                      RegExp regex = RegExp(pattern);
                                      if (value == null || value.isEmpty || !regex.hasMatch(value)) {
                                        return 'Enter a valid email address';
                                      } else {
                                        return null;
                                      }
                                    },
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
                                  child: TextFormField(
                                    controller: _socialSecurityController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: const OutlineInputBorder(),
                                      contentPadding: const EdgeInsets.symmetric(
                                        vertical: 9.0,
                                      ),
                                      hintText: '*** - *** - ***',
                                      hintStyle: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF77838F),
                                      ),
                                    ),
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.text,
                                    autocorrect: false,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == '') {
                                        return 'Please enter your SSN';
                                      } else {
                                        return null;
                                      }
                                    },
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate() && !sent) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                );

                                await UserRepository.update(
                                  interac: _interacController.text,
                                  ssn: _socialSecurityController.text,
                                );

                                myProfile = await UserRepository.get();

                                setState(() {
                                  sent = !sent;
                                });

                                navigatorKey.currentState!.pop();
                              }
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                    color: sent ? kBluePrimary : Colors.transparent,
                                  ),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(sent ? kBluePrimary.withOpacity(0.05) : kBluePrimary),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                              child: Text(
                                sent ? 'Sent' : 'Send',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: sent ? kBluePrimary : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
