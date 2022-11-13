import 'package:connectnwork/constants.dart';
import 'package:connectnwork/dialogs/address_verification_dialog.dart';
import 'package:connectnwork/repos/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showUsernameDialog() async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  if (myProfile!.firstName != null) {
    firstNameController.text = myProfile!.firstName!;
  }

  if (myProfile!.lastName != null) {
    lastNameController.text = myProfile!.lastName!;
  }

  if (myProfile!.phoneNumber != null) {
    phoneController.text = myProfile!.phoneNumber!;
  }

  return showDialog(
    barrierDismissible: false,
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Form(
              key: formKey,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(19, 18, 19, 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigatorKey.currentState!.pop();
                      },
                      child: SvgPicture.asset(
                        'assets/back_button.svg',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'First Name',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
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
                            controller: firstNameController,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == '') {
                                return 'Please enter your first name';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.fromLTRB(17.0, 14.0, 10.0, 16.0),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFDADADA),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFDADADA),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Last Name',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
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
                            controller: lastNameController,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == '') {
                                return 'Please enter your last name';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.fromLTRB(17.0, 14.0, 10.0, 16.0),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFDADADA),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Phone number',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
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
                            controller: phoneController,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            validator: (value) {
                              if (value == '') {
                                return 'Please enter your phone number';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.fromLTRB(17.0, 14.0, 10.0, 16.0),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFDADADA),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
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
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                phoneNumber: phoneController.text,
                              );

                              navigatorKey.currentState!.pop();
                              navigatorKey.currentState!.pop();
                              showAddressVerificationDialog();
                            }
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
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
                                'Next',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
            ),
          );
        },
      );
    },
  );
}
