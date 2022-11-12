import 'dart:convert';
import 'dart:io';

import 'package:connectnwork/constants.dart';
import 'package:connectnwork/dialogs/address_verification_dialog.dart';
import 'package:connectnwork/dialogs/id_verification_dialog.dart';
import 'package:connectnwork/dialogs/username_dialog.dart';
import 'package:connectnwork/repos/user_repository.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/drawer.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController _phoneController = TextEditingController();
  int currentStep = 1;
  bool verified = false;
  String userProfilePicture = '';

  @override
  Widget build(BuildContext context) {
    if (myProfile!.picture != null) {
      userProfilePicture = myProfile!.picture!;
    }

    if (myProfile!.idVerified != null) {
      verified = myProfile!.idVerified!;
    }

    if (myProfile!.phoneNumber != null) {
      _phoneController.text = myProfile!.phoneNumber!;
    }

    return ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: const CustomDrawer(),
        appBar: const CustomAppBar(
          title: 'My Profile',
          drawer: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 18.0,
              right: 18.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 97,
                  width: 231,
                  padding: const EdgeInsets.all(
                    8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0ff0000d),
                        blurRadius: 30,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          ImagePicker picker = ImagePicker();
                          late XFile? image;

                          if (Platform.isIOS) {
                            showCupertinoModalPopup(
                              context: navigatorKey.currentContext!,
                              builder: (context) {
                                return CupertinoActionSheet(
                                  actions: [
                                    CupertinoActionSheetAction(
                                      child: const Text('Camera'),
                                      onPressed: () async {
                                        Navigator.pop(context);

                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          },
                                        );

                                        image = await picker.pickImage(
                                          source: ImageSource.camera,
                                        );

                                        if (image != null) {
                                          File imageFile = File(image!.path);
                                          Uint8List imagebytes = await imageFile.readAsBytes();
                                          String base64string = base64.encode(imagebytes);

                                          await UserRepository.update(picture: base64string);

                                          myProfile = await UserRepository.get();

                                          setState(() {
                                            userProfilePicture = myProfile!.picture!;
                                          });
                                        }

                                        navigatorKey.currentState!.pop();
                                      },
                                    ),
                                    CupertinoActionSheetAction(
                                      child: const Text('Gallery'),
                                      onPressed: () async {
                                        navigatorKey.currentState!.pop();

                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          },
                                        );

                                        image = await picker.pickImage(
                                          source: ImageSource.gallery,
                                        );

                                        if (image != null) {
                                          File imageFile = File(image!.path);
                                          Uint8List imagebytes = await imageFile.readAsBytes();
                                          String base64string = base64.encode(imagebytes);

                                          await UserRepository.update(picture: base64string);

                                          myProfile = await UserRepository.get();

                                          setState(() {
                                            userProfilePicture = myProfile!.picture!;
                                          });
                                        }

                                        navigatorKey.currentState!.pop();
                                      },
                                    ),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      navigatorKey.currentState!.pop();
                                    },
                                  ),
                                );
                              },
                            );
                          } else {
                            showModalBottomSheet(
                              context: navigatorKey.currentContext!,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    ListTile(
                                      title: const Text('Camera'),
                                      onTap: () async {
                                        Navigator.pop(context);

                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          },
                                        );

                                        image = await picker.pickImage(
                                          source: ImageSource.camera,
                                        );

                                        if (image != null) {
                                          File imageFile = File(image!.path);
                                          Uint8List imagebytes = await imageFile.readAsBytes();
                                          String base64string = base64.encode(imagebytes);

                                          UserRepository.update(picture: base64string);

                                          myProfile = await UserRepository.get();

                                          setState(() {
                                            userProfilePicture = myProfile!.picture!;
                                          });
                                        }

                                        navigatorKey.currentState!.pop();
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('Gallery'),
                                      onTap: () async {
                                        Navigator.pop(context);

                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          },
                                        );

                                        image = await picker.pickImage(
                                          source: ImageSource.gallery,
                                        );

                                        if (image != null) {
                                          File imageFile = File(image!.path);
                                          Uint8List imagebytes = await imageFile.readAsBytes();
                                          String base64string = base64.encode(imagebytes);

                                          UserRepository.update(picture: base64string);

                                          myProfile = await UserRepository.get();

                                          setState(() {
                                            userProfilePicture = myProfile!.picture!;
                                          });
                                        }

                                        navigatorKey.currentState!.pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(),
                          ),
                          child: Image.network(
                            // imageUrl:
                            userProfilePicture,
                            fit: BoxFit.cover,
                            //progressIndicatorBuilder: (context, url, error) => const CircularProgressIndicator(),
                            errorBuilder: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      if (myProfile!.fullName != null)
                        Text(
                          myProfile!.fullName!,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 17,
                // ),
                // Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.only(
                //     top: 8.0,
                //     left: 18.0,
                //     right: 18.0,
                //     bottom: 10.0,
                //   ),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(20),
                //     boxShadow: const [
                //       BoxShadow(
                //         color: Color(0x0ff0000d),
                //         blurRadius: 30,
                //         offset: Offset(0, 20),
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Phone',
                //         style: GoogleFonts.montserrat(
                //           fontWeight: FontWeight.w600,
                //           color: Colors.black,
                //           fontSize: 12,
                //         ),
                //       ),
                //       Row(
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           Expanded(
                //             child: Container(
                //               padding: const EdgeInsets.only(
                //                 top: 7.5,
                //               ),
                //               child: TextField(
                //                 controller: _phoneController,
                //                 textAlign: TextAlign.center,
                //                 decoration: InputDecoration(
                //                   isDense: true,
                //                   contentPadding: const EdgeInsets.symmetric(
                //                     vertical: 5,
                //                   ),
                //                   hintText: '+1 514 521 2526',
                //                   hintStyle: GoogleFonts.montserrat(
                //                     fontWeight: FontWeight.w400,
                //                     fontSize: 12,
                //                     color: const Color(0xFFDADADA),
                //                   ),
                //                   border: const OutlineInputBorder(),
                //                 ),
                //                 style: GoogleFonts.montserrat(
                //                   fontWeight: FontWeight.w400,
                //                   color: Colors.black,
                //                   fontSize: 12,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 25,
                //           ),
                //           GestureDetector(
                //             onTap: () async {
                //               showDialog(
                //                 context: context,
                //                 barrierDismissible: false,
                //                 builder: (context) {
                //                   return const Center(
                //                     child: CircularProgressIndicator(),
                //                   );
                //                 },
                //               );
                //
                //               await UserRepository.update(phoneNumber: _phoneController.text);
                //
                //               navigatorKey.currentState!.pop();
                //             },
                //             child: Text(
                //               'Update number',
                //               style: GoogleFonts.montserrat(
                //                 fontWeight: FontWeight.w400,
                //                 color: const Color(0xFFDADADA),
                //                 fontSize: 12,
                //                 decoration: TextDecoration.underline,
                //               ),
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 20,
                //           ),
                //           // Column(
                //           //   children: [
                //           //     Text(
                //           //       'Phone Number Verified',
                //           //       style: GoogleFonts.montserrat(
                //           //         fontWeight: FontWeight.w400,
                //           //         color: Colors.black,
                //           //         fontSize: 8,
                //           //       ),
                //           //     ),
                //           //     const SizedBox(
                //           //       height: 5,
                //           //     ),
                //           //     const Icon(
                //           //       Icons.check_box,
                //           //       color: Color(0xFF3DD598),
                //           //     ),
                //           //   ],
                //           // ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 24,
                ),
                if (myProfile!.idVerified == null || myProfile!.idVerified! == false)
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Complete these 2 steps so ',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const TextSpan(
                          text: 'you can start taking shifts with Connect&Work!',
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 18.0,
                    left: 12.0,
                    right: 12.0,
                    bottom: 40.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFF009FE3),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0ff0000d),
                        blurRadius: 30,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFF009FE3),
                              borderRadius: BorderRadius.circular(
                                60.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '1',
                                style: GoogleFonts.montserrat(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 2,
                            width: 30,
                            color: const Color(0xFF009FE3),
                          ),
                          Container(
                            height: 2,
                            width: 30,
                            color: currentStep == 2 ? const Color(0xFF009FE3) : const Color(0xFFE3F1FC),
                          ),
                          Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: currentStep == 2 ? const Color(0xFF009FE3) : Colors.white,
                              border: currentStep == 2
                                  ? Border.all(
                                      color: const Color(0xFF000000),
                                    )
                                  : Border.all(
                                      color: const Color(0xFFE3F1FC),
                                    ),
                              borderRadius: BorderRadius.circular(
                                60.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '2',
                                style: GoogleFonts.montserrat(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: currentStep == 2 ? Colors.white : const Color(0xFF009FE3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF009FE3).withOpacity(0.06),
                              border: Border.all(
                                color: const Color(0xFF009FE3),
                              ),
                              borderRadius: BorderRadius.circular(
                                5.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 26.0,
                                vertical: 6.0,
                              ),
                              child: Text(
                                'ID verification',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: const Color(0xFF009FE3),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 13.5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: currentStep == 2 ? const Color(0xFF009FE3).withOpacity(0.06) : const Color(0xFFFFFFFF),
                              border: currentStep == 2
                                  ? Border.all(
                                      color: const Color(0xFF009FE3),
                                    )
                                  : Border.all(
                                      color: const Color(0xFFE5E5E5),
                                    ),
                              borderRadius: BorderRadius.circular(
                                5.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 26.0,
                                vertical: 6.0,
                              ),
                              child: Text(
                                'Files',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: currentStep == 2 ? const Color(0xFF009FE3) : const Color(0xFFE5E5E5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      if (myProfile!.idVerified == null || myProfile!.idVerified! == false)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Certn is a third-party service that Connect&Work uses to perform compliant ID verification.',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: 2,
                              ),
                            ),
                            Text(
                              'Certn will keep your information private and secure.',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: 2,
                              ),
                            ),
                            const SizedBox(
                              height: 76,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (myProfile!.firstName == null || myProfile!.lastName == null || myProfile!.phoneNumber == null) {
                                      showUsernameDialog();
                                    } else if (myProfile!.dob == null || myProfile!.address == null) {
                                      showAddressVerificationDialog();
                                    } else {
                                      showIDVerificationDialog();
                                    }
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF009FE3),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 3.0,
                                    ),
                                    child: Text(
                                      'Go to Certn',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      if (myProfile!.idVerified != null && myProfile!.idVerified! == true)
                        Column(
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            Text(
                              'Your identity is verified.',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kBluePrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'Update info',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
