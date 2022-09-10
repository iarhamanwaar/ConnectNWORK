import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool drawer;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      leading: Builder(
        builder: (BuildContext context) {
          if (!drawer) {
            return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                'assets/back_button.png',
                fit: BoxFit.cover,
              ),
            );
          } else {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              icon: Image.asset(
                'assets/drawer_icon.png',
                fit: BoxFit.cover,
              ),
            );
          }
        },
      ),
      actions: [
        IconButton(
          icon: Image.asset(
            'assets/bell_icon.png',
            fit: BoxFit.cover,
          ),
          onPressed: () {},
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
