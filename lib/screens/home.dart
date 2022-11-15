import 'package:connectnwork/constants.dart';
import 'package:connectnwork/models/earnings_model.dart';
import 'package:connectnwork/models/job_model.dart';
import 'package:connectnwork/repos/jobs_repository.dart';
import 'package:connectnwork/screens/job_details.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/drawer.dart';
import 'package:connectnwork/widgets/browse_job_card.dart';
import 'package:connectnwork/widgets/earning_card.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:connectnwork/widgets/schedule.dart';
import 'package:connectnwork/widgets/toggle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
      child: Scaffold(
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
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: IndexedStack(
                index: kStackIndex,
                children: const [
                  BrowseJobs(),
                  ScheduleWidget(),
                  EarningsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BrowseJobs extends StatefulWidget {
  const BrowseJobs({Key? key}) : super(key: key);

  @override
  State<BrowseJobs> createState() => _BrowseJobsState();
}

class _BrowseJobsState extends State<BrowseJobs> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<Job>? data;

  void _onRefresh() async {
    List<Job>? tempLoad = await JobsRepository.browse();

    setState(() {
      data = tempLoad;
    });

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    List<Job>? tempLoad = await JobsRepository.browse();

    setState(() {
      data = tempLoad;
    });

    _refreshController.loadComplete();
  }

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

    List<Job>? tempData = await JobsRepository.browse();

    setState(() {
      data = tempData;
    });

    navigatorKey.currentState!.pop();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>?>(
      future: JobsRepository.browse(),
      builder: (context, snapshot) {
        data = snapshot.data;

        if (data != null) {
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const ClassicHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text("Pull up to refresh");
                } else if (mode == LoadStatus.loading) {
                  body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Refresh failed, retry please");
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text("Release to refresh");
                } else {
                  body = const Text("No new jobs");
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: data!.length,
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              itemBuilder: (context, index) {
                final Job job = data![index];

                return Column(
                  children: [
                    BrowseJobCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetailsScreen(
                              job: job,
                            ),
                          ),
                        ).then((value) => onGoBack());
                      },
                      job: job,
                      dateWithTime: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            ),
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

class EarningsWidget extends StatelessWidget {
  const EarningsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Earnings>?>(
      future: JobsRepository.getEarnings(period: 'thisWeek'),
      builder: (context, snapshot) {
        final List<Earnings>? data = snapshot.data;

        if (snapshot.hasData) {
          DateTime sunday = mostRecentSunday(DateTime.now());
          DateTime saturday = sunday.add(const Duration(days: 6));

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Paid on ${DateFormat.MMMd().format(data![0].paidOn!)}',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 8,
                            letterSpacing: 2,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      Text(
                        '\$${data[0].total}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          letterSpacing: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Paid on ${DateFormat.MMMd().format(data[0].paidOn!)}',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 8,
                            letterSpacing: 2,
                            color: const Color(0xFF77838F),
                          ),
                        ),
                      ),
                    ],
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
