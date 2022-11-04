import 'package:connectnwork/constants.dart';
import 'package:connectnwork/models/employee_job_model.dart';
import 'package:connectnwork/repos/jobs_repository.dart';
import 'package:connectnwork/screens/cancelled_job.dart';
import 'package:connectnwork/screens/pending_job.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/drawer.dart';
import 'package:connectnwork/widgets/jobs_toggle_button.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:connectnwork/widgets/schedule_job_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyJobs extends StatefulWidget {
  const MyJobs({Key? key}) : super(key: key);

  @override
  State<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  int kStackIndex = 0;
  List<EmployeeJob>? completed;
  List<EmployeeJob>? pending;
  List<EmployeeJob>? cancelled;

  onGoBack() async {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    List<EmployeeJob>? tempCompleted = await JobsRepository.get(status: 'completed');
    List<EmployeeJob>? tempPending = await JobsRepository.get(status: 'pending');
    List<EmployeeJob>? tempCancelled = await JobsRepository.get(status: 'cancelled');

    setState(() {
      completed = tempCompleted;
      pending = tempPending;
      cancelled = tempCancelled;
    });

    navigatorKey.currentState!.pop();
  }

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
        body: FutureBuilder(
          future: Future.wait([
            JobsRepository.get(status: 'completed'),
            JobsRepository.get(status: 'pending'),
            JobsRepository.get(status: 'cancelled'),
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.data != null) {
              completed = snapshot.data![0];
              pending = snapshot.data![1];
              cancelled = snapshot.data![1];

              return Padding(
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
                    const SizedBox(
                      height: 60,
                    ),
                    Expanded(
                      child: IndexedStack(
                        index: kStackIndex,
                        children: [
                          Timesheets(
                            completed: completed,
                            onGoBack: onGoBack,
                          ),
                          Pending(
                            pending: pending,
                            onGoBack: onGoBack,
                          ),
                          Cancelled(
                            cancelled: cancelled,
                            onGoBack: onGoBack,
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
      ),
    );
  }
}

class Timesheets extends StatelessWidget {
  final List<EmployeeJob>? completed;
  final Function() onGoBack;

  const Timesheets({
    Key? key,
    required this.completed,
    required this.onGoBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (completed != null) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: completed!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ScheduleJobCard(
                job: completed![index],
                onPress: () {},
                completed: true,
                dateWithTime: true,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        },
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
    }
  }
}

class Pending extends StatelessWidget {
  final List<EmployeeJob>? pending;
  final Function() onGoBack;

  const Pending({
    Key? key,
    required this.pending,
    required this.onGoBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pending != null) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: pending!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ScheduleJobCard(
                job: pending![index],
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PendingJobScreen(
                        job: pending![index],
                      ),
                    ),
                  ).then((value) => onGoBack());
                },
                pending: true,
                dateWithTime: true,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        },
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
    }
  }
}

class Cancelled extends StatelessWidget {
  final List<EmployeeJob>? cancelled;
  final Function() onGoBack;

  const Cancelled({
    Key? key,
    required this.cancelled,
    required this.onGoBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cancelled != null) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: cancelled!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ScheduleJobCard(
                job: cancelled![index],
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CancelledJobScreen(
                        job: cancelled![index],
                      ),
                    ),
                  ).then((value) => onGoBack());
                },
                cancelled: true,
                dateWithTime: true,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        },
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
    }
  }
}
