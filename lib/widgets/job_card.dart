import 'package:connectnwork/constants.dart';
import 'package:connectnwork/screens/job_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobCard extends StatelessWidget {
  final String title;
  final double rate;
  final String vendor;
  final String time;
  final bool recurring;
  final String logo;
  final bool tips;
  final String location;

  const JobCard({
    Key? key,
    required this.title,
    required this.rate,
    required this.vendor,
    required this.time,
    required this.recurring,
    required this.logo,
    required this.tips,
    required this.location,
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
        height: 200,
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
            Padding(
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
