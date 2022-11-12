import 'package:connectnwork/constants.dart';
import 'package:connectnwork/models/employee_job_model.dart';
import 'package:connectnwork/repos/jobs_repository.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/browse_job_card.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:connectnwork/widgets/schedule_job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelledJobScreen extends StatefulWidget {
  final EmployeeJob job;

  const CancelledJobScreen({
    Key? key,
    required this.job,
  }) : super(key: key);

  @override
  State<CancelledJobScreen> createState() => _CancelledJobScreenState();
}

class _CancelledJobScreenState extends State<CancelledJobScreen> {
  @override
  Widget build(BuildContext context) {
    bool detailed = false;

    if (widget.job.job!.shift!.days!.length > 1) {
      detailed = true;
    }

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
                ScheduleJobCard(
                  onPress: () {},
                  job: widget.job,
                  cancelled: true,
                  detailed: detailed,
                  dateWithTime: true,
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
                  child: HtmlWidget(
                    widget.job.job!.description!,
                    textStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 29,
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
