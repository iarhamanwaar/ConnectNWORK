import 'package:connectnwork/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToggleButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool active;

  const ToggleButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            border: active
                ? Border.all(
                    color: kBluePrimary,
                    width: 2,
                  )
                : Border.all(
                    color: const Color(0xFFDADADA),
                  ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.05),
                blurRadius: 30,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              icon,
              color: active ? kBluePrimary : const Color(0xFFDADADA),
              size: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: GoogleFonts.montserrat(
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            fontSize: 10,
            color: active ? kBluePrimary : const Color(0xFF77838F),
          ),
        ),
      ],
    );
  }
}
