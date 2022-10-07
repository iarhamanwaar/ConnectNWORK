import 'package:connectnwork/models/employee_job_model.dart';
import 'package:connectnwork/repos/jobs_repository.dart';
import 'package:connectnwork/screens/weekly_details.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WeeklyEarningsScreen extends StatefulWidget {
  const WeeklyEarningsScreen({Key? key}) : super(key: key);

  @override
  State<WeeklyEarningsScreen> createState() => _WeeklyEarningsScreenState();
}

class _WeeklyEarningsScreenState extends State<WeeklyEarningsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          title: 'Transfers',
          drawer: false,
        ),
        body: SafeArea(
          child: FutureBuilder<List<EmployeeJob>?>(
            future: JobsRepository.get(status: 'paid'),
            builder: (context, snapshot) {
              final data = snapshot.data;

              if (data != null) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
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
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 22,
                              ),
                              Text(
                                'Weekly deposit to bank',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.black,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          elevation: 0,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return WeeklyDetailsScreen(
                                                  weekStart: data[index].earnings![0].period!.start!,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 24.0,
                                            right: 24.0,
                                            top: 4.0,
                                            bottom: 4.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                DateFormat.MMMd().format(data[index].earnings![0].period!.start!),
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 2,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                '\$${data[index].earnings![0].total}',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 2,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Color(0xFFDADADA),
                                        thickness: 1.5,
                                        height: 0,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
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
      ),
    );
  }
}
