import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobsToggleButton extends StatelessWidget {
  final String text;
  final bool active;

  const JobsToggleButton({
    Key? key,
    required this.text,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: active
            ? Border.all(
                color: Colors.black,
                width: 1,
              )
            : Border.all(
                color: Colors.transparent,
              ),
        borderRadius: BorderRadius.circular(10),
        color: active ? const Color(0xFFFFFCF2) : Colors.white,
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
