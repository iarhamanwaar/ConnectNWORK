import 'package:connectnwork/constants.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpScreen({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool confirmPasswordVisible = true;
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SvgPicture.asset(
                      'assets/logo.svg',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Sign Up',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/fb-logo.svg'),
                        const SizedBox(
                          width: 50,
                        ),
                        SvgPicture.asset('assets/google-logo.svg'),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Or register with email',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _firstNameController,
                                  keyboardType: TextInputType.name,
                                  autocorrect: false,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Please enter a first name';
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    hintText: 'First name',
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
                            height: 4,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _lastNameController,
                                  keyboardType: TextInputType.name,
                                  autocorrect: false,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Please enter a last name';
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    hintText: 'Last name',
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
                            height: 4,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    String pattern =
                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                        r"{0,253}[a-zA-Z0-9])?)*$";
                                    RegExp regex = RegExp(pattern);
                                    if (value == null ||
                                        value.isEmpty ||
                                        !regex.hasMatch(value)) {
                                      return 'Enter a valid email address';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(0, 15, 0, 15),
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
                            height: 4,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: passwordVisible,
                                  autocorrect: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Please enter a password';
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    hintText: 'Password',
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
                              IconButton(
                                icon: const Icon(
                                  Icons.visibility,
                                  color: Color(0xFF77838F),
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText: confirmPasswordVisible,
                                  autocorrect: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value != _passwordController.text) {
                                      return 'Passowrd does not match';
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    hintText: 'Confirm password',
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
                              IconButton(
                                icon: const Icon(
                                  Icons.visibility,
                                  color: Color(0xFF77838F),
                                ),
                                onPressed: () {
                                  setState(() {
                                    confirmPasswordVisible =
                                        !confirmPasswordVisible;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 2.0,
                              right: 100.0,
                            ),
                            child: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'By signing up, you agree to our',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF77838F),
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Terms & Conditions',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF009FE3),
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' and',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF77838F),
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Privacy Policy',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF009FE3),
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 23,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 54.0,
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
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        );

                                        try {
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                            email: _emailController.text.trim(),
                                            password: _passwordController.text,
                                          );
                                        } on FirebaseAuthException catch (e) {
                                          print(e);
                                        }

                                        navigatorKey.currentState!
                                            .popUntil((route) => route.isFirst);
                                      }
                                    },
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color(0xFF009FE3),
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                          vertical: 15.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Sign Up',
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
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF77838F),
                    ),
                    text: 'Join us before? ',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Sign In',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF009FE3),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
