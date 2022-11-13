import 'package:connectnwork/constants.dart';
import 'package:connectnwork/models/employee_job_model.dart';
import 'package:connectnwork/repos/jobs_repository.dart';
import 'package:connectnwork/widgets/schedule_job_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({Key? key}) : super(key: key);

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
        future: Future.wait([
          JobsRepository.get(status: 'inProgress'),
          JobsRepository.get(status: 'hired'),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.data != null) {
            List<EmployeeJob>? inProgress = snapshot.data![0];
            List<EmployeeJob>? hired = snapshot.data![1];

            if (inProgress != null && hired != null) {
              return Column(
                children: [
                  Padding(
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
                                'Hi ${myProfile!.firstName}, Here is your next schedule.',
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
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: inProgress.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ScheduleJobCard(
                                  job: inProgress[index],
                                  onPress: () {},
                                  inProgress: true,
                                  dateWithTime: true,
                                  detailed: true,
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: hired.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ScheduleJobCard(
                                  job: hired[index],
                                  onPress: () {},
                                  hired: true,
                                  dateWithTime: true,
                                  detailed: true,
                                ),
                                const SizedBox(
                                  height: 9,
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
            } else if (inProgress != null && hired == null) {
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
                            'Hi ${myProfile!.firstName}, Here is your next schedule.',
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
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: inProgress.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ScheduleJobCard(
                              job: inProgress[index],
                              onPress: () {},
                              inProgress: true,
                              dateWithTime: true,
                              detailed: true,
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              );
            } else if (inProgress == null && hired != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: hired.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ScheduleJobCard(
                              job: hired[index],
                              onPress: () {},
                              hired: true,
                              dateWithTime: true,
                              detailed: true,
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 58.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
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
              );
            }
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
