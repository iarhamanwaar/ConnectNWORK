import 'package:connectnwork/constants.dart';
import 'package:connectnwork/screens/job_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobCard extends StatelessWidget {
  final String title;
  final double rate;
  final String vendor;
  final String time;
  final String logo;
  final String location;
  final bool tips;
  final bool recurring;
  final bool detailed;
  final bool hired;
  final bool inProgress;
  final bool completed;
  final bool pending;
  final bool cancelled;
  final bool cancelledByEmployer;

  const JobCard({
    Key? key,
    required this.title,
    required this.rate,
    required this.vendor,
    required this.time,
    this.recurring = false,
    required this.logo,
    this.tips = false,
    required this.location,
    this.detailed = false,
    this.hired = false,
    this.inProgress = false,
    this.completed = false,
    this.pending = false,
    this.cancelled = false,
    this.cancelledByEmployer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const JobDetailsScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: detailed ? 268 : 200,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.only(
                top: 15,
                left: 13,
                right: 30,
              ),
              child: Stack(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: Text(
                      '\$$rate/hr',
                      style: tips
                          ? GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            )
                          : const TextStyle(
                              fontSize: 14,
                            ),
                    ),
                  ),
                  tips
                      ? Positioned(
                          top: 23,
                          left: 80,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: const Color(0xFFFFF2D2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 4,
                            ),
                            child: Center(
                              child: Text(
                                '+ Tips',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Positioned(
                    top: 55,
                    child: Text(
                      vendor,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      logo,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
              color: Color(0xFFDADADA),
            ),
            const SizedBox(
              height: 15,
            ),
            detailed
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 21,
                          right: 21,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: kOrangePrimary,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  time,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: kOrangePrimary,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Lun 30 Mai - Mar 31 Mai - Jeu 2 Juin',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                                height: 1.5,
                                color: kOrangePrimary,
                              ),
                            ),
                            Text(
                              'Dim 5 Juin - Lun 6 Juin - Mer 8 Juin',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                                height: 1.5,
                                color: kOrangePrimary,
                              ),
                            ),
                            Text(
                              'Ven 10 Juin - Sam 11 Juin - Dim 12 Juin',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                                height: 1.5,
                                color: kOrangePrimary,
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: Color(0xFFDADADA),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 14,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: recurring ? kOrangePrimary : kBluePrimary,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            recurring ? '$time Recurring days' : time,
                            style: TextStyle(
                              fontSize: 14,
                              color: recurring ? kOrangePrimary : kBluePrimary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.place_outlined,
                      size: 20,
                      color: Color(0xFF77838F),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        location,
                        style: const TextStyle(
                          color: Color(0xFF77838F),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                if (hired)
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF3DD598).withOpacity(0.1),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 3,
                            ),
                            child: Text(
                              'Hired',
                              style: TextStyle(
                                color: Color(0xFF049B13),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                if (inProgress)
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF974A).withOpacity(0.1),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 3,
                            ),
                            child: Text(
                              'Shift in Progress',
                              style: TextStyle(
                                color: Color(0xFFFF974A),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                if (completed)
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF3DD598).withOpacity(0.1),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 3,
                            ),
                            child: Text(
                              'Completed',
                              style: TextStyle(
                                color: Color(0xFF3DD598),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                if (pending)
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF50B5FF).withOpacity(0.1),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 3,
                            ),
                            child: Text(
                              'Pending',
                              style: TextStyle(
                                color: Color(0xFF50B5FF),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                if (cancelled)
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFC5A5A).withOpacity(0.1),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 3,
                            ),
                            child: Text(
                              'Cancelled',
                              style: TextStyle(
                                color: Color(0xFFFC5A5A),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                if (cancelledByEmployer)
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFC5A5A).withOpacity(0.1),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 3,
                            ),
                            child: Text(
                              'Cancelled by\nEmployer',
                              style: TextStyle(
                                color: Color(0xFFFC5A5A),
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
