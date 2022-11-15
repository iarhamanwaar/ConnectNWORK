import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectnwork/constants.dart';
import 'package:connectnwork/repos/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnverifiedDrawer extends StatelessWidget {
  const UnverifiedDrawer({Key? key}) : super(key: key);

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
              decoration: currentPage == '/my_profile' || currentPage == '/main'
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
                  color: currentPage == '/my_profile' || currentPage == '/main' ? kBluePrimary : Colors.black,
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
                        color: currentPage == '/my_profile' || currentPage == '/main' ? kBluePrimary : Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  if (currentPage != '/my_profile' && currentPage != '/main') {
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
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  size: 28,
                  color: Colors.black,
                ),
                title: Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Logout',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );

                  String? deviceIdToken = await FirebaseMessaging.instance.getToken();

                  if (deviceIdToken != null) {
                    await UserRepository.deleteNotifcation(id: deviceIdToken);
                  }

                  try {
                    await FirebaseAuth.instance.signOut();
                  } on FirebaseException {
                    rethrow;
                  }

                  navigatorKey.currentState!.popUntil((route) => route.isFirst);

                  navigatorKey.currentState!.pushReplacementNamed('/main');
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
