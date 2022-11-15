import 'dart:convert';
import 'dart:io';

import 'package:connectnwork/constants.dart';
import 'package:connectnwork/dialogs/address_verification_dialog.dart';
import 'package:connectnwork/dialogs/id_completion_dialog.dart';
import 'package:connectnwork/dialogs/id_verification_dialog.dart';
import 'package:connectnwork/dialogs/update_info_dialog.dart';
import 'package:connectnwork/dialogs/username_dialog.dart';
import 'package:connectnwork/repos/user_repository.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/drawer.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:connectnwork/widgets/unverified_drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  FilePickerResult? resume;
  FilePickerResult? workPermit;
  File? resumeFile;
  File? workPermitFile;
  bool resumeUploaded = false;
  bool workPermitUploaded = false;
  bool resumeSubmitted = false;

  @override
  Widget build(BuildContext context) {
    if (myProfile!.picture != null) {
      userProfilePicture = myProfile!.picture!;
    }

    if (myProfile!.certnVerify != null && myProfile!.certnVerify! == true) {
      currentStep = 2;
    }

    if (myProfile!.idVerified != null && myProfile!.idVerified! == true) {
      currentStep = 1;
      verified = true;
    }

    if (myProfile!.phoneNumber != null) {
      _phoneController.text = myProfile!.phoneNumber!;
    }

    if (myProfile!.resume != null) {
      resumeUploaded = true;
      resumeSubmitted = true;
    }

    if (myProfile!.workPermit != null) {
      workPermitUploaded = true;
    }

    return ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: verified ? const CustomDrawer() : const UnverifiedDrawer(),
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
                            userProfilePicture,
                            fit: BoxFit.cover,
                            errorBuilder: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      if (myProfile!.firstName != null && myProfile!.lastName != null)
                        Expanded(
                          child: Text(
                            '${myProfile!.firstName} ${myProfile!.lastName}',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      if (myProfile!.firstName != null && myProfile!.lastName == null)
                        Expanded(
                          child: Text(
                            '${myProfile!.firstName}',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      if (myProfile!.lastName != null && myProfile!.firstName == null)
                        Expanded(
                          child: Text(
                            '${myProfile!.lastName}',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 14,
                              height: 1.5,
                            ),
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
                if (verified == false)
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
                  width: double.infinity,
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
                      if (verified == false)
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
                                        color: const Color(0xFF009FE3),
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
                      if (verified == false)
                        const SizedBox(
                          height: 22,
                        ),
                      if (verified == false)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: currentStep == 1 ? const Color(0xFF009FE3).withOpacity(0.06) : const Color(0xFFFFFFFF),
                                border: currentStep == 1
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
                                  'ID verification',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: currentStep == 1 ? const Color(0xFF009FE3) : const Color(0xFFE5E5E5),
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
                      if (currentStep == 1 && verified == false && (myProfile!.certnVerify != null && myProfile!.certnVerify! == false))
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
                                      showUsernameDialog().then((value) => setState(() {
                                            myProfile;
                                          }));
                                    } else if (myProfile!.dob == null || myProfile!.address == null) {
                                      showAddressVerificationDialog().then((value) => setState(() {
                                            myProfile;
                                          }));
                                    } else {
                                      showIDVerificationDialog().then((value) => setState(() {
                                            myProfile;
                                          }));
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
                      if (currentStep == 1 && verified == false && (myProfile!.certnVerify != null && myProfile!.certnVerify! == true))
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your ID verification is being processed and will take few minutes to be completed.',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: 2,
                              ),
                            ),
                          ],
                        ),
                      if (currentStep == 2 && verified == false)
                        Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Upload your latest resume',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  height: 2,
                                ),
                                children: [
                                  TextSpan(
                                    text: '*',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                      height: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: resumeSubmitted == true
                                      ? null
                                      : () async {
                                          resume = await FilePicker.platform.pickFiles();

                                          if (resume != null) {
                                            resumeFile = File(resume!.files.single.path!);

                                            setState(() {
                                              resumeUploaded = true;
                                            });
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 0,
                                    backgroundColor: resumeUploaded == false ? const Color(0xFF77838F) : const Color(0xFF31C889).withOpacity(0.1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 3.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.image,
                                          color: resumeUploaded == false ? Colors.white : const Color(0xFF31C889),
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          resumeUploaded == false ? 'Upload File' : 'File uploaded',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: resumeUploaded == false ? Colors.white : const Color(0xFF31C889),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Upload a valid work and study permit',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: 2,
                              ),
                            ),
                            Text(
                              '(for non permanent residents or canadian citizens)',
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                                height: 2,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: resumeSubmitted == true
                                      ? null
                                      : () async {
                                          workPermit = await FilePicker.platform.pickFiles();

                                          if (workPermit != null) {
                                            workPermitFile = File(workPermit!.files.single.path!);

                                            setState(() {
                                              workPermitUploaded = true;
                                            });
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 0,
                                    backgroundColor: workPermitUploaded == false ? const Color(0xFF77838F) : const Color(0xFF31C889).withOpacity(0.1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 3.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.image,
                                          color: workPermitUploaded == false ? Colors.white : const Color(0xFF31C889),
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          workPermitUploaded == false ? 'Upload File' : 'File uploaded',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: workPermitUploaded == false ? Colors.white : const Color(0xFF31C889),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      if (verified == true)
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
                              onPressed: () async {
                                await showUpdateInfoDialog();
                              },
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
                const SizedBox(
                  height: 20,
                ),
                if (verified == false && currentStep == 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (resumeSubmitted == false)
                        ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );

                            if (resumeFile != null && workPermitFile != null) {
                              Uint8List resumeBytes = await resumeFile!.readAsBytes();
                              String resumeBase64string = base64.encode(resumeBytes);

                              Uint8List workPermitBytes = await workPermitFile!.readAsBytes();
                              String workPermitBase64string = base64.encode(workPermitBytes);

                              await UserRepository.update(
                                resume: resumeBase64string,
                                workPermit: workPermitBase64string,
                              );
                            } else if (resumeFile != null && workPermitFile == null) {
                              Uint8List resumeBytes = await resumeFile!.readAsBytes();
                              String resumeBase64string = base64.encode(resumeBytes);

                              await UserRepository.update(
                                resume: resumeBase64string,
                              );
                            } else if (resumeFile == null && workPermitFile != null) {
                              Uint8List workPermitBytes = await workPermitFile!.readAsBytes();
                              String workPermitBase64string = base64.encode(workPermitBytes);

                              await UserRepository.update(
                                workPermit: workPermitBase64string,
                              );
                            }

                            myProfile = await UserRepository.get();

                            setState(() {
                              myProfile;
                            });

                            navigatorKey.currentState!.pop();

                            await showIdCompletionDialog();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 0,
                            backgroundColor: const Color(0xFF009FE3),
                          ),
                          child: Text(
                            'Complete Profile',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      if (resumeSubmitted == true)
                        Text(
                          'Under Review',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 24, color: const Color(0xFFEF6E45)),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
