import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EarningCard extends StatelessWidget {
  final String title;
  final String vendor;
  final double bill;
  final String shiftId;

  const EarningCard({
    Key? key,
    required this.title,
    required this.vendor,
    required this.bill,
    required this.shiftId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                '\$$bill',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            vendor,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Shift ID  :  $shiftId',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
