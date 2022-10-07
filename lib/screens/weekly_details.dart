import 'package:connectnwork/models/employee_job_model.dart';
import 'package:connectnwork/repos/jobs_repository.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/earning_card.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WeeklyDetailsScreen extends StatefulWidget {
  final DateTime weekStart;

  const WeeklyDetailsScreen({
    Key? key,
    required this.weekStart,
  }) : super(key: key);

  @override
  State<WeeklyDetailsScreen> createState() => _WeeklyDetailsScreenState();
}

class _WeeklyDetailsScreenState extends State<WeeklyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          title: 'Transfer Detail',
          drawer: false,
        ),
        body: FutureBuilder<List<EmployeeJob>?>(
            future: JobsRepository.get(status: 'paid'),
            builder: (context, snapshot) {
              final data = snapshot.data;

              if (data != null) {
                DateTime sunday = mostRecentSunday(DateTime.now());
                DateTime saturday = sunday.add(const Duration(days: 6));
                List<EmployeeJob> thisWeekJobs = [];
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

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Week (${DateFormat.MMMd().format(sunday)} - ${DateFormat.MMMd().format(saturday)}) total earnings',
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
                                    bill: thisWeekJobs[index].earnings![0].total!.toDouble(),
                                    shiftId: thisWeekJobs[index].job!.id!,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

DateTime mostRecentSunday(DateTime date) => DateTime(date.year, date.month, date.day - date.weekday % 7);
