import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectnwork/constants.dart';
import 'package:connectnwork/dialogs/id_verification_dialog.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/drawer.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: const CustomDrawer(),
        appBar: const CustomAppBar(
          title: 'My Profile',
          drawer: true,
        ),
        body: FutureBuilder(
          future: sanityClient
              .fetch('*[_type == "screens" && slug.current == "my-profile"]'),
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (data != null) {
              return SingleChildScrollView(
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
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: CachedNetworkImage(
                                imageUrl: myProfile.user.picture,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                myProfile.user.fullName,
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
                      const SizedBox(
                        height: 17,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 18.0,
                          right: 18.0,
                          bottom: 10.0,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      top: 7.5,
                                    ),
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 5),
                                        hintText: myProfile.user.phoneNumber,
                                        hintStyle: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                        border: const OutlineInputBorder(),
                                      ),
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 9.5,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Update number',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFFDADADA),
                                      fontSize: 12,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Phone Number Verified',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 8,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Icon(
                                      Icons.check_box,
                                      color: Color(0xFF3DD598),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
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
                              text:
                                  'you can start taking shifts with Connect&Work!',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      if (!myProfile.user.idVerified)
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: currentStep == 2
                                        ? const Color(0xFF009FE3)
                                        : const Color(0xFFE3F1FC),
                                  ),
                                  Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: currentStep == 2
                                          ? const Color(0xFF009FE3)
                                          : Colors.white,
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
                                          color: currentStep == 2
                                              ? Colors.white
                                              : const Color(0xFF009FE3),
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
                                      color: const Color(0xFF009FE3)
                                          .withOpacity(0.06),
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
                                      color: currentStep == 2
                                          ? const Color(0xFF009FE3)
                                              .withOpacity(0.06)
                                          : const Color(0xFFFFFFFF),
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
                                          color: currentStep == 2
                                              ? const Color(0xFF009FE3)
                                              : const Color(0xFFE5E5E5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
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
                                      if (myProfile.user.dob == null ||
                                          myProfile.user.address == null) {
                                        //await addressPopUp();
                                        showIDVerificationDialog(context);
                                      }
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateProperty.all(
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
                        ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future addressPopUp() {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController dobController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController aptController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: dobController,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter a date of birth';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(17.0, 14.0, 10.0, 16.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFDADADA),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: const Icon(
                            Icons.calendar_month_outlined,
                          ),
                          hintText: 'DD/MM/YYYY',
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
                        onChanged: (value) {},
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(17.0, 14.0, 10.0, 16.0),
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(17.0, 14.0, 10.0, 16.0),
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // TODO: call patch api, show loading, recall myprofile maybe, move to next page
                          navigatorKey.currentState!.pop();
                          showIDVerificationDialog(context);
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
      ),
    );
  }
}
