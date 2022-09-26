import 'package:connectnwork/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

Future<void> showIDVerificationDialog() async {
  int currentStep = 0;

  return await showDialog(
    barrierDismissible: false,
    context: navigatorKey.currentContext!,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return IndexedStack(
            index: currentStep,
            children: [
              Step1(
                callback: () {
                  setState(() {
                    currentStep = 1;
                  });
                },
              ),
              Step2(
                callback: () {
                  setState(() {
                    currentStep = 0;
                  });
                },
              ),
            ],
          );
        },
      );
    },
  );
}

class Step1 extends StatefulWidget {
  final Function() callback;

  const Step1({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> list = <String>[
    'Passport',
    'Driving License',
    'ID Card',
    'Visa',
  ];

  var dropdownValue = null;

  final ImagePicker picker = ImagePicker();

  XFile? frontOfID;
  XFile? backOfID;

  @override
  Widget build(BuildContext context) {
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
                height: 20,
              ),
              Text(
                'ID',
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
                    child: DropdownButtonFormField<String>(
                      isDense: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(
                          left: 18,
                          top: 8,
                          bottom: 8,
                          right: 10,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      value: dropdownValue,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFFDADADA),
                      ),
                      elevation: 20,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select an ID Type';
                        } else {
                          return null;
                        }
                      },
                      hint: Text(
                        'Select the ID Type',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFDADADA),
                        ),
                      ),
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.25,
                        color: Colors.black,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Front of ID',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          frontOfID = await picker.pickImage(
                            source: ImageSource.camera,
                          );
                          setState(() {
                            frontOfID;
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: SvgPicture.asset(
                            'assets/image_thumbnail.svg',
                          ),
                        ),
                      ),
                      if (frontOfID != null)
                        Container(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          width: 100,
                          child: Text(
                            frontOfID!.name,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Back of ID',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Not necessary for passport ',
                          style: GoogleFonts.montserrat(
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            letterSpacing: 0.25,
                          ),
                          children: [
                            TextSpan(
                              text: '*',
                              style: GoogleFonts.montserrat(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () async {
                          backOfID = await picker.pickImage(
                            source: ImageSource.camera,
                          );
                          setState(() {
                            backOfID;
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: SvgPicture.asset(
                            'assets/image_thumbnail.svg',
                          ),
                        ),
                      ),
                      if (backOfID != null)
                        Container(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          width: 100,
                          child: Text(
                            backOfID!.name,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
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
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (frontOfID != null && backOfID != null) {
                          widget.callback();
                        } else if (frontOfID != null && backOfID == null) {
                          if (dropdownValue == 'Passport') {
                            widget.callback();
                          }
                        }
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
                        horizontal: 10.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        'Next',
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
      ),
    );
  }
}

class Step2 extends StatefulWidget {
  final Function() callback;

  const Step2({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  final ImagePicker picker = ImagePicker();

  XFile? facePicture;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(19, 18, 19, 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.callback();
                  },
                  child: SvgPicture.asset(
                    'assets/back_button.svg',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Take a picture of yourself',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 74,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    facePicture = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    setState(() {
                      facePicture;
                    });
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: SvgPicture.asset(
                      'assets/image_thumbnail.svg',
                    ),
                  ),
                ),
                if (facePicture != null)
                  Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    width: 100,
                    child: Text(
                      facePicture!.name,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 90,
            ),
            ElevatedButton(
              onPressed: () {
                if (facePicture != null) {}
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
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'Send',
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
      ),
    );
  }
}
