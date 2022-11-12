import 'package:connectnwork/constants.dart';
import 'package:connectnwork/dialogs/apply_job_dialog.dart';
import 'package:connectnwork/models/job_model.dart';
import 'package:connectnwork/repos/jobs_repository.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/browse_job_card.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;

  const JobDetailsScreen({
    Key? key,
    required this.job,
  }) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController cancelController = TextEditingController();
  bool applied = false;

  @override
  Widget build(BuildContext context) {
    bool detailed = false;

    if (widget.job.shift!.days!.length > 1) {
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
                BrowseJobCard(
                  onPress: () {},
                  job: widget.job,
                  dateWithTime: !detailed,
                  detailed: detailed,
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
                    widget.job.description!,
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
                if (!applied)
                  ElevatedButton(
                    onPressed: () async {
                      if (myProfile!.interac == null || myProfile!.interac! == '') {
                        showDialog(
                          barrierDismissible: true,
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
                                    onPressed: () {
                                      navigatorKey.currentState!.popUntil((route) => route.isFirst);

                                      navigatorKey.currentState!.pushReplacementNamed('/main');
                                      navigatorKey.currentState!.pushNamed('/settings');
                                      navigatorKey.currentState!.pushNamed('/payments');
                                    },
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
                      } else {
                        await showApplyJobDialog();

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );

                        await JobsRepository.apply(jobId: widget.job.id!);

                        navigatorKey.currentState!.pop();

                        setState(() {
                          applied = true;
                        });

                        showDialog(
                          barrierDismissible: false,
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
                                    onPressed: () {
                                      navigatorKey.currentState!.pop();
                                    },
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
                if (applied)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 35.0,
                                  vertical: 25,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Are you sure you want to cancel this shift?',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            navigatorKey.currentState!.pop();

                                            await showDialog(
                                              barrierDismissible: true,
                                              context: navigatorKey.currentContext!,
                                              builder: (_) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                content: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 35.0,
                                                    vertical: 25,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        height: 120,
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          key: formKey,
                                                          controller: cancelController,
                                                          minLines: null,
                                                          maxLines: null,
                                                          expands: true,
                                                          autocorrect: false,
                                                          keyboardType: TextInputType.text,
                                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                                          validator: (value) {
                                                            if (value == '') {
                                                              return 'Please enter a reason';
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                          decoration: const InputDecoration(
                                                            enabledBorder: InputBorder.none,
                                                            isDense: false,
                                                            hintText: 'Write the cancellation reason ...',
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 50,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          navigatorKey.currentState!.pop();

                                                          showDialog(
                                                            context: context,
                                                            barrierDismissible: false,
                                                            builder: (context) {
                                                              return const Center(
                                                                child: CircularProgressIndicator(),
                                                              );
                                                            },
                                                          );

                                                          await JobsRepository.cancel(
                                                            jobId: widget.job.id!,
                                                            cancelReason: cancelController.text,
                                                          );

                                                          navigatorKey.currentState!.pop();

                                                          await showDialog(
                                                            barrierDismissible: false,
                                                            context: navigatorKey.currentContext!,
                                                            builder: (_) => AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20),
                                                              ),
                                                              content: Padding(
                                                                padding: const EdgeInsets.symmetric(
                                                                  horizontal: 35.0,
                                                                  vertical: 25,
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Text(
                                                                      'Your application has been cancelled.',
                                                                      textAlign: TextAlign.center,
                                                                      style: GoogleFonts.montserrat(
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 18,
                                                                        color: kBluePrimary,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 50,
                                                                    ),
                                                                    ElevatedButton(
                                                                      onPressed: () {
                                                                        setState(() {
                                                                          applied = false;
                                                                        });

                                                                        navigatorKey.currentState!.pop();
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                        backgroundColor: Colors.white,
                                                                        elevation: 0,
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          side: const BorderSide(
                                                                            color: kBluePrimary,
                                                                            width: 2,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                          vertical: 15.0,
                                                                          horizontal: 15.0,
                                                                        ),
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
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Colors.white,
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                            side: const BorderSide(
                                                              color: kBluePrimary,
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                            vertical: 15.0,
                                                            horizontal: 15.0,
                                                          ),
                                                          child: Text(
                                                            'Send',
                                                            style: GoogleFonts.montserrat(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w600,
                                                              color: kBluePrimary,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              side: const BorderSide(color: kBluePrimary, width: 2),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 15.0,
                                              horizontal: 15.0,
                                            ),
                                            child: Text(
                                              'Yes',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: kBluePrimary,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            navigatorKey.currentState!.pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: kBluePrimary,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 15.0,
                                              horizontal: 15.0,
                                            ),
                                            child: Text(
                                              'No',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                              color: kBluePrimary,
                              width: 2,
                            ),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 18.0,
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: kBluePrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
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
