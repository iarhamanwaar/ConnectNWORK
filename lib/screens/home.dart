import 'package:connectnwork/constants.dart';
import 'package:connectnwork/models/employee_job_model.dart' as ej;
import 'package:connectnwork/models/job_model.dart';
import 'package:connectnwork/repos/jobs_repository.dart';
import 'package:connectnwork/repos/user_repository.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/drawer.dart';
import 'package:connectnwork/widgets/earning_card.dart';
import 'package:connectnwork/widgets/browse_job_card.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:connectnwork/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
                          text: 'Browse Jobs',
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
                        Earnings(),
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
      future: JobsRepository.browse(),
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
                  BrowseJobCard(
                    job: job,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 58.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/no_shifts.png',
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
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
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
    return FutureBuilder(
      future: Future.wait([
        JobsRepository.get(status: 'inProgress'),
        JobsRepository.get(status: 'hired'),
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.data![0] != null || snapshot.data![1] != null) {
          List<ej.EmployeeJob>? inProgress = snapshot.data![0];
          List<ej.EmployeeJob>? hired = snapshot.data![1];

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
                        'Hi ${myProfile!.user!.firstName}, Here is your next schedule.',
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
                //const BrowseJobCard(job: job)
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
              ],
            ),
          );
        } else if (snapshot.data![0] == null && snapshot.data![1] == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 58.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/no_schedule.png',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'There are no shifts yet on your schedule',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 100,
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
    );
  }
}

class Earnings extends StatelessWidget {
  const Earnings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ej.EmployeeJob>?>(
      future: JobsRepository.get(status: 'paid'),
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data != null) {
          DateTime sunday = mostRecentSunday(DateTime.now());
          DateTime saturday = sunday.add(const Duration(days: 6));
          List<ej.EmployeeJob> thisWeekJobs = [];
          double totalEarnings = 0.0;

          for (int i = 0; i < data.length; i++) {
            for (int j = 0; j < data[i].earnings!.length; j++) {
              if (data[i].earnings![j].period!.start!.toLocal().isAfter(sunday) && data[i].earnings![j].period!.start!.toLocal().isBefore(saturday)) {
                thisWeekJobs.add(data[i]);
              }
            }
          }

          for (int i = 0; i < thisWeekJobs.length; i++) {
            for (int j = 0; j < thisWeekJobs[i].earnings!.length; j++) {
              if (thisWeekJobs[i].earnings![j].period!.start!.toLocal().isAfter(sunday) && thisWeekJobs[i].earnings![j].period!.start!.toLocal().isBefore(saturday)) {
                totalEarnings = thisWeekJobs[i].earnings![j].earning!;
              }
            }
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'This week (${DateFormat.MMMd().format(sunday)} - ${DateFormat.MMMd().format(saturday)}) total earnings',
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
                  '\$$totalEarnings',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                ElevatedButton(
                  onPressed: () {
                    navigatorKey.currentState!.pushNamed('/weekly_earnings');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: thisWeekJobs.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        EarningCard(
                          title: thisWeekJobs[index].job!.title!,
                          vendor: thisWeekJobs[index].job!.employer!.name!,
                          bill: thisWeekJobs[index].earnings![0].earning!,
                          shiftId: thisWeekJobs[index].job!.id!,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        } else if (data == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 58.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/no_earnings.png',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'You haven’t earn money yet.',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 100,
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
    );
  }
}

DateTime mostRecentSunday(DateTime date) => DateTime(date.year, date.month, date.day - date.weekday % 7);
