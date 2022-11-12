import 'package:connectnwork/constants.dart';
import 'package:connectnwork/utils.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                'assets/back_button.svg',
              ),
            ),
          ),
          title: Text(
            'Sign In',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: false,
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, false);
            return false;
          },
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SvgPicture.asset(
                        'assets/logo.svg',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Forgot your password?',
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 37,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 33.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Please enter your email address below to reset your password.',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Email address*',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _emailController,
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
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                      hintText: 'Email',
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF77838F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 54.5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 57.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            },
                                          );

                                          bool errorFlag = false;

                                          try {
                                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                              email: _emailController.text.trim(),
                                            );
                                          } on FirebaseAuthException catch (e) {
                                            errorFlag = true;
                                            Utils.showSnackbar(e.message);
                                          }

                                          navigatorKey.currentState!.pop();

                                          if (!errorFlag) {
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                content: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 47.0,
                                                    vertical: 16,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        'We sent new password on your email',
                                                        style: GoogleFonts.montserrat(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w700,
                                                          height: 1.5,
                                                          color: const Color(0xFF009FE3),
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      const SizedBox(
                                                        height: 25,
                                                      ),
                                                      OutlinedButton(
                                                        onPressed: () {
                                                          navigatorKey.currentState!.popAndPushNamed('temp_password');
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                          child: Text(
                                                            'Close',
                                                            style: GoogleFonts.montserrat(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w600,
                                                              color: kBluePrimary,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor: MaterialStateProperty.all(
                                          const Color(0xFF009FE3),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                            vertical: 15.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Send',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF77838F),
                          ),
                          text: 'First time here? ',
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context, true);
                                },
                              text: 'Sign Up',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF009FE3),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
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
