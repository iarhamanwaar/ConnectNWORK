import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/drawer.dart';
import 'package:connectnwork/widgets/jobs_toggle_button.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyJobs extends StatefulWidget {
  const MyJobs({Key? key}) : super(key: key);

  @override
  State<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  int kStackIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
      child: Scaffold(
        drawer: const CustomDrawer(),
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          title: 'My Jobs',
          drawer: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          kStackIndex = 0;
                        });
                      },
                      child: JobsToggleButton(
                        text: 'Timesheets',
                        active: kStackIndex == 0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          kStackIndex = 1;
                        });
                      },
                      child: JobsToggleButton(
                        text: 'Pending',
                        active: kStackIndex == 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          kStackIndex = 2;
                        });
                      },
                      child: JobsToggleButton(
                        text: 'Cancelled',
                        active: kStackIndex == 2,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: IndexedStack(
                  index: kStackIndex,
                  children: const [
                    Timesheets(),
                    Pending(),
                    Cancelled(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Timesheets extends StatelessWidget {
  const Timesheets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data != null) {
          return Column(
            children: const [
              SizedBox(
                height: 62,
              ),
              // JobCard(
              //   title: 'Aide Boulanger',
              //   rate: 18.75,
              //   vendor: 'Bridor Boucherville',
              //   time: 'Sep 4, 2021 19:00 - 23:30',
              //   location: '4455 Rue cote Marquette H2G 1R2, Laval, QC',
              //   logo: 'assets/bridor_logo.png',
              //   completed: true,
              // ),
              SizedBox(
                height: 25,
              ),
              // JobCard(
              //   title: 'Valet',
              //   rate: 15.55,
              //   vendor: 'Best Western Montreal Downtown',
              //   time: 'Sep 5, 2021 08:00 - 15:30',
              //   location: '4455 Rue cote Marquette H2G 1R2, Laval, QC',
              //   logo: 'assets/best_western_logo.png',
              //   completed: true,
              // ),
            ],
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
                    'assets/no_timesheet.png',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'You haven’t complete a shift yet.',
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

class Pending extends StatelessWidget {
  const Pending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data != null) {
          return Column(
            children: const [
              SizedBox(
                height: 62,
              ),
              // JobCard(
              //   title: 'Aide Boulanger',
              //   rate: 18.75,
              //   vendor: 'Bridor Boucherville',
              //   time: 'Sep 4, 2021 19:00 - 23:30',
              //   location: '4455 Rue cote Marquette H2G 1R2, Laval, QC',
              //   logo: 'assets/bridor_logo.png',
              //   pending: true,
              // ),
              SizedBox(
                height: 25,
              ),
              // JobCard(
              //   title: 'Valet',
              //   rate: 15.55,
              //   vendor: 'Best Western Montreal Downtown',
              //   time: 'Sep 5, 2021 08:00 - 15:30',
              //   location: '4455 Rue cote Marquette H2G 1R2, Laval, QC',
              //   logo: 'assets/best_western_logo.png',
              //   pending: true,
              // ),
            ],
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
                    'assets/no_pending.png',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'No pending shifts',
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

class Cancelled extends StatelessWidget {
  const Cancelled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data != null) {
          return Column(
            children: const [
              SizedBox(
                height: 62,
              ),
              // JobCard(
              //   title: 'Aide Boulanger',
              //   rate: 18.75,
              //   vendor: 'Bridor Boucherville',
              //   time: 'Sep 4, 2021 19:00 - 23:30',
              //   location: '4455 Rue cote Marquette H2G 1R2, Laval, QC',
              //   logo: 'assets/bridor_logo.png',
              //   cancelled: true,
              // ),
              SizedBox(
                height: 25,
              ),
              // JobCard(
              //   title: 'Valet',
              //   rate: 15.55,
              //   vendor: 'Best Western Montreal Downtown',
              //   time: 'Sep 5, 2021 08:00 - 15:30',
              //   location: '4455 Rue cote Marquette H2G 1R2, Laval, QC',
              //   logo: 'assets/best_western_logo.png',
              //   cancelledByEmployer: true,
              // ),
            ],
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
                    'assets/no_cancelled.png',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'No cancelled shifts',
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
