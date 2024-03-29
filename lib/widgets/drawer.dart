import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectnwork/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentPage = ModalRoute.of(context)!.settings.name!;

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 270,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Color(0xFFEEF9FF),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(255, 101, 0, 0.302),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: myProfile == null && myProfile!.picture != null
                          ? const CircleAvatar(
                              child: Icon(Icons.account_circle),
                            )
                          : Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: myProfile!.picture!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        myProfile == null && myProfile!.fullName != null ? 'Loading' : myProfile!.fullName!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 38,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: currentPage == '/home' || currentPage == '/main'
                  ? BoxDecoration(
                      color: const Color(0xFFE3F1FC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: kBluePrimary,
                      ),
                    )
                  : const BoxDecoration(
                      color: Colors.transparent,
                    ),
              child: ListTile(
                leading: Icon(
                  Icons.home_outlined,
                  size: 28,
                  color: currentPage == '/home' || currentPage == '/main' ? kBluePrimary : Colors.black,
                ),
                title: Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Home',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: currentPage == '/home' || currentPage == '/main' ? kBluePrimary : Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  if (currentPage != '/home' && currentPage != '/main') {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: currentPage == '/my_jobs'
                  ? BoxDecoration(
                      color: const Color(0xFFE3F1FC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: kBluePrimary,
                      ),
                    )
                  : const BoxDecoration(
                      color: Colors.transparent,
                    ),
              child: ListTile(
                leading: Icon(
                  Icons.description_outlined,
                  size: 28,
                  color: currentPage == '/my_jobs' ? kBluePrimary : Colors.black,
                ),
                title: Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      'My Jobs',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: currentPage == '/my_jobs' ? kBluePrimary : Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  if (currentPage != '/my_jobs') {
                    Navigator.pushReplacementNamed(context, '/my_jobs');
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: currentPage == '/my_profile'
                  ? BoxDecoration(
                      color: const Color(0xFFE3F1FC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: kBluePrimary,
                      ),
                    )
                  : const BoxDecoration(
                      color: Colors.transparent,
                    ),
              child: ListTile(
                leading: Icon(
                  Icons.person_outlined,
                  size: 28,
                  color: currentPage == '/my_profile' ? kBluePrimary : Colors.black,
                ),
                title: Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      'My Profile',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: currentPage == '/my_profile' ? kBluePrimary : Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  if (currentPage != '/my_profile') {
                    Navigator.pushReplacementNamed(context, '/my_profile');
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: currentPage == '/settings'
                  ? BoxDecoration(
                      color: const Color(0xFFE3F1FC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: kBluePrimary,
                      ),
                    )
                  : const BoxDecoration(
                      color: Colors.transparent,
                    ),
              child: ListTile(
                leading: Icon(
                  Icons.settings_outlined,
                  size: 28,
                  color: currentPage == '/settings' ? kBluePrimary : Colors.black,
                ),
                title: Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Settings',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: currentPage == '/settings' ? kBluePrimary : Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  if (currentPage != '/settings') {
                    Navigator.pushReplacementNamed(context, '/settings');
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: currentPage == '/support'
                  ? BoxDecoration(
                      color: const Color(0xFFE3F1FC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: kBluePrimary,
                      ),
                    )
                  : const BoxDecoration(
                      color: Colors.transparent,
                    ),
              child: ListTile(
                leading: Icon(
                  Icons.support_agent_outlined,
                  size: 28,
                  color: currentPage == '/support' ? kBluePrimary : Colors.black,
                ),
                title: Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Support',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: currentPage == '/support' ? kBluePrimary : Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  if (currentPage != '/support') {
                    Navigator.pushReplacementNamed(context, '/support');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
