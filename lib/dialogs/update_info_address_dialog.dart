import 'dart:convert';
import 'dart:io';

import 'package:connectnwork/constants.dart';
import 'package:connectnwork/dialogs/update_info_complete_dialog.dart';
import 'package:connectnwork/models/iaddress_schema.dart';
import 'package:connectnwork/repos/location_repository.dart';
import 'package:connectnwork/repos/user_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showUpdateInfoAddressDialog() async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController aptController = TextEditingController();
  List<IAddressSchema> address = [];
  IAddressSchema? selectedAddress;
  bool search = false;
  FilePickerResult? resume;
  File? resumeFile;
  bool resumeUploaded = false;

  if (myProfile!.address != null && myProfile!.address!.formattedAddress != null) {
    addressController.text = myProfile!.address!.formattedAddress!;
    if (myProfile!.address!.apt != null) aptController.text = myProfile!.address!.apt!;
    selectedAddress = myProfile!.address!.toIAddressSchema();
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
                      'Address',
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
                            onChanged: (value) async {
                              search = true;
                              selectedAddress = null;
                              if (value != '' && search) {
                                address = await LocationRepository.getAddress(value);
                                setState(() {
                                  address;
                                });
                              }
                            },
                            controller: addressController,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == '') {
                                return 'Please enter an address';
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
                              hintText: 'Search address',
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
                    SizedBox(
                      height: 35.0 * address.length + 15,
                      child: ListView.builder(
                        itemCount: address.length,
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFDADADA),
                              ),
                              borderRadius: BorderRadius.vertical(
                                top: index == 0 ? const Radius.circular(10) : Radius.zero,
                                bottom: index == address.length - 1 ? const Radius.circular(10) : Radius.zero,
                              ),
                            ),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedAddress = address[index];
                                      address = [];
                                      addressController.text = selectedAddress!.formattedAddress;
                                      search = false;
                                    });
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Color(0xFFDADADA),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        address[index].formattedAddress,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.25,
                                          height: 1.5,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 115,
                          child: TextFormField(
                            controller: aptController,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.fromLTRB(17.0, 14.0, 10.0, 16.0),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFDADADA),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Apt #',
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
                      height: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          'Update your latest resume',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
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
                              onPressed: () async {
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
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate() && selectedAddress != null) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );

                              selectedAddress!.apt = aptController.text;

                              await UserRepository.update(
                                address: selectedAddress,
                              );

                              if (resumeFile != null) {
                                Uint8List resumeBytes = await resumeFile!.readAsBytes();
                                String resumeBase64string = base64.encode(resumeBytes);

                                UserRepository.update(resume: resumeBase64string);
                              }

                              myProfile = await UserRepository.get();

                              navigatorKey.currentState!.pop();
                              navigatorKey.currentState!.pop();
                              showUpdateInfoCompleteDialog();
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
                                'Send',
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
