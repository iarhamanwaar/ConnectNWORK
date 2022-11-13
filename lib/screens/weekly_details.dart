import 'package:connectnwork/models/earnings_model.dart';
import 'package:connectnwork/repos/jobs_repository.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/earning_card.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WeeklyDetailsScreen extends StatefulWidget {
  final DateTime weekStart;
  final DateTime weekEnd;

  const WeeklyDetailsScreen({
    Key? key,
    required this.weekStart,
    required this.weekEnd,
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
        body: FutureBuilder<List<Earnings>?>(
            future: JobsRepository.getEarnings(
              startDate: widget.weekStart.toString(),
              endDate: widget.weekEnd.toString(),
            ),
            builder: (context, snapshot) {
              final data = snapshot.data;

              if (data != null) {
                DateTime sunday = mostRecentSunday(widget.weekStart);
                DateTime saturday = sunday.add(const Duration(days: 6));

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
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            '\$${data[0].total}',
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
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data[0].jobs!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  EarningCard(
                                    title: data[0].jobs![index].job!.title!,
                                    vendor: data[0].jobs![index].job!.employer!.name!,
                                    bill: data[0].jobs![index].job!.shift!.ratePerHr! * data[0].jobs![index].job!.shift!.paidHrs!,
                                    shiftId: data[0].jobs![index].job!.shift!.id!,
                                  ),
                                ],
                              );
                            },
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                              vertical: 20,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Deductions Quebec',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Annuity',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '${data[0].deductions!.annuity!}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Insurance',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '${data[0].deductions!.insurance!}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'RQAP',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '${data[0].deductions!.rqap!}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'QC Tax',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '${data[0].deductions!.qcTax!}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Federal Tax',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '${data[0].deductions!.fedTax!}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                        color: Colors.black,
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
