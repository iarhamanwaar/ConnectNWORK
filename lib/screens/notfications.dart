import 'package:connectnwork/constants.dart';
import 'package:connectnwork/models/notification_model.dart' as n;
import 'package:connectnwork/repos/user_repository.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<n.Notification>? data;

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: Text(
            'Notifications',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                'assets/back_button.svg',
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: UserRepository.getNotifcations(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              data = snapshot.data;

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: data!.length,
                padding: const EdgeInsets.symmetric(vertical: 30),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          children: [
                            if (data![index].tag! == 'card') SvgPicture.asset('assets/notifications/card.svg'),
                            if (data![index].tag! == 'tick') SvgPicture.asset('assets/notifications/tick.svg'),
                            if (data![index].tag! == 'time') SvgPicture.asset('assets/notifications/time.svg'),
                            if (data![index].tag! == 'cross') SvgPicture.asset('assets/notifications/cross.svg'),
                            if (data![index].tag! == 'new') SvgPicture.asset('assets/notifications/new.svg'),
                            const SizedBox(width: 20),
                            Expanded(
                              child: HtmlWidget(
                                data![index].body!,
                                textStyle: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  height: 1.3,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                      context: navigatorKey.currentContext!,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    );

                                    await UserRepository.deleteNotifcation(id: data![index].id!);

                                    List<n.Notification>? tempData = await UserRepository.getNotifcations();

                                    setState(() {
                                      data = tempData;
                                    });

                                    navigatorKey.currentState!.pop();
                                  },
                                  child: const Icon(
                                    FontAwesomeIcons.xmarkCircle,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        thickness: 1,
                        height: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Color(0xFFDADADA),
                      ),
                    ],
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Empty',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'You don’t have any notifications at this time',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
