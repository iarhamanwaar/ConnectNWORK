import 'package:connectnwork/constants.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/job_card.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          title: 'Job Details',
          drawer: false,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 19.0,
              right: 19,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const JobCard(
                  title: 'Aide Boulanger',
                  rate: 18.75,
                  vendor: 'Bridor Boucherville',
                  time: '14:30 - 22:30',
                  recurring: true,
                  location: '4455 Rue cote Marquette H2G 1R2, Laval, QC',
                  tips: true,
                  logo: 'assets/bridor_logo.png',
                  detailed: true,
                ),
                const SizedBox(
                  height: 34,
                ),
                Text(
                  'Job Description',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 25,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF000000).withOpacity(0.05),
                        blurRadius: 30,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Text(
                    'According to legend, ancestors of today\'s Oromo people in a region of Kaffa in Ethiopia were believed to have been the first to recognize the energizing effect of the coffee plant. [6]',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 47,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (false) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 47.0,
                              vertical: 25,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'You must setup your receiving bank account before applying to shifts',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                OutlinedButton(
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Go to Payments Settings',
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

                    if (true) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 47.0,
                              vertical: 25,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Congratulation! You will get notified once you are selected.',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    color: kBluePrimary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                OutlinedButton(
                                  onPressed: () {},
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
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(kBluePrimary),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 18.0,
                    ),
                    child: Text(
                      'Apply',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
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