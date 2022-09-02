import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentStep = 1;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFCFECF8),
            Color(0xFFFFFCF2),
          ],
          stops: [
            0.01,
            0.41,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: const Drawer(
          backgroundColor: Colors.black,
        ),
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                icon: Image.asset(
                  'drawer_icon.png',
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Image.asset(
                'bell_icon.png',
                fit: BoxFit.cover,
              ),
              onPressed: () {},
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
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
                      Image.asset(
                        'profile_avatar.png',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          'Jennifer Lawson',
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
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                  hintText: '+1 514 521 2526',
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
                            onPressed: () {},
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}