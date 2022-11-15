import 'package:connectnwork/constants.dart';
import 'package:connectnwork/dialogs/id_verification_dialog.dart';
import 'package:connectnwork/models/iaddress_schema.dart';
import 'package:connectnwork/repos/location_repository.dart';
import 'package:connectnwork/repos/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Future<void> showAddressVerificationDialog() async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController aptController = TextEditingController();
  DateTime? picked;
  List<IAddressSchema> address = [];
  IAddressSchema? selectedAddress;
  bool search = false;

  if (myProfile!.dob != null) {
    dobController.text = DateFormat.yMd().format(myProfile!.dob!);
  }

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
                      'Date of birth',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        picked = null;
                        picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            dobController.text = '${picked?.day}/${picked?.month}/${picked?.year}';
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(17.0, 14.0, 14.0, 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFDADADA),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              dobController.text == '' ? 'DD/MM/YYYY' : dobController.text,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: dobController.text == '' ? const Color(0xFFDADADA) : Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.calendar_month_outlined,
                              color: dobController.text == '' ? const Color(0xFFDADADA) : Colors.black,
                              size: 18,
                            ),
                          ],
                        ),
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
                      height: 82,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate() && dobController.text != '' && selectedAddress != null) {
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
                                dob: picked,
                                address: selectedAddress,
                              );

                              navigatorKey.currentState!.pop();
                              navigatorKey.currentState!.pop();
                              showIDVerificationDialog();
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
