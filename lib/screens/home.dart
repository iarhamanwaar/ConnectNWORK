import 'dart:convert';

import 'package:connectnwork/constants.dart';
import 'package:connectnwork/models/job_model.dart';
import 'package:connectnwork/models/sanity_home.dart' as sanity;
import 'package:connectnwork/repos/jobs_repository.dart';
import 'package:connectnwork/repos/user_repository.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/drawer.dart';
import 'package:connectnwork/widgets/earning_card.dart';
import 'package:connectnwork/widgets/job_card.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:connectnwork/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int kStackIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
      child: FutureBuilder(
        future: Future.wait([
          UserRepository.get(),
          //sanityClient.fetch('*[_type == "screens" && slug.current == "home"]'),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.data != null) {
            myProfile = snapshot.data![0];
            //final data = jsonDecode(snapshot.data![1]);

            return Scaffold(
              backgroundColor: Colors.transparent,
              drawer: const CustomDrawer(),
              appBar: const CustomAppBar(
                title: 'Home',
                drawer: true,
              ),
              body: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            kStackIndex = 0;
                          });
                        },
                        child: ToggleButton(
                          icon: Icons.search,
                          text: 'Browse',
                          active: kStackIndex == 0 ? true : false,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            kStackIndex = 1;
                          });
                        },
                        child: ToggleButton(
                          icon: Icons.calendar_month,
                          text: 'Schedule',
                          active: kStackIndex == 1 ? true : false,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            kStackIndex = 2;
                          });
                        },
                        child: ToggleButton(
                          icon: Icons.attach_money,
                          text: 'Earnings',
                          active: kStackIndex == 2 ? true : false,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: kStackIndex,
                      children: const [
                        BrowseJobs(),
                        Schedule(),
                        Center(
                          child: Earnings(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class BrowseJobs extends StatelessWidget {
  const BrowseJobs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>?>(
      future: JobsRepository.get(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data != null) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
            ),
            itemBuilder: (context, index) {
              final Job job = data[index];

              return Column(
                children: [
                  if (index == 0)
                    const SizedBox(
                      height: 60,
                    ),
                  JobCard(
                    job: job,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          );
        } else if (data == null) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 58.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 80,
                ),
                SvgPicture.asset(
                  'assets/no_shifts.svg',
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'No shifts available',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'We have no shifts available yet but we are working on it.',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: const Color(0xFF77838F),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Please activate your notications to be the among the first to receive shifts opportunities.',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: const Color(0xFF77838F),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Thank you!',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: const Color(0xFF77838F),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.05),
                  blurRadius: 30,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Center(
                child: Text(
                  'Hi Jennifer, Here is your next schedule.',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          // const JobCard(
          //   title: 'Bus Boy',
          //   rate: 15.75,
          //   vendor: 'Mac Donald Downtown Montreal',
          //   time: 'Sep 1st, 2021 18:00 - 22:30',
          //   location: '4455 Rue cote Marquette H2G 1R2, Laval, QC',
          //   logo: 'assets/mcdonalds_logo.png',
          //   inProgress: true,
          // ),
          const SizedBox(
            height: 103,
          ),
          Text(
            'Shifts coming up.',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          // const JobCard(
          //   title: 'Bus Boy',
          //   rate: 15.75,
          //   vendor: 'Mac Donald Downtown Montreal',
          //   time: '18:00 - 22:30',
          //   location: '4455 Rue cote Marquette H2G 1R2, Laval, QC',
          //   logo: 'assets/mcdonalds_logo.png',
          //   recurring: true,
          //   hired: true,
          // ),
        ],
      ),
    );
  }
}

class Earnings extends StatelessWidget {
  const Earnings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(
            'This week (Jan 20 - Jan 26) total earnings',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            '\$0',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(
            height: 19,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    top: 14.0,
                    bottom: 14.0,
                  ),
                  child: Text(
                    'Other weekly deposit to bank',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      letterSpacing: 0.25,
                      color: kBluePrimary,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    right: 12.0,
                    top: 14.0,
                    bottom: 14.0,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: kBluePrimary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const EarningCard(
            title: 'Bus boy',
            vendor: 'Mac Donald Downtown Montreal',
            bill: 350,
            shiftId: 'IA1556S',
          ),
          const SizedBox(
            height: 20,
          ),
          const EarningCard(
            title: 'W2 - Order picker',
            vendor: 'Fedex Lachine',
            bill: 500,
            shiftId: 'IA14456S',
          ),
        ],
      ),
    );
  }
}
