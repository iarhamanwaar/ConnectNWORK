import 'package:connectnwork/constants.dart';
import 'package:connectnwork/screens/home.dart';
import 'package:connectnwork/screens/job_details.dart';
import 'package:connectnwork/screens/main_page.dart';
import 'package:connectnwork/screens/my_jobs.dart';
import 'package:connectnwork/screens/my_profile.dart';
import 'package:connectnwork/screens/payments_setup.dart';
import 'package:connectnwork/screens/reset_password.dart';
import 'package:connectnwork/screens/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sanity/flutter_sanity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  sanityClient = SanityClient(
    dataset: 'production',
    projectId: '7d3rcta7',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'ConnectNWork',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/main',
      routes: {
        '/main': (context) => const MainPage(),
        '/home': (context) => const HomeScreen(),
        '/reset_password': (context) => const ResetPasswordPage(),
        '/my_jobs': (context) => const MyJobs(),
        '/job_details': (context) => const JobDetailsScreen(),
        '/my_profile': (context) => const MyProfileScreen(),
        '/settings': (context) => const SettingsPage(),
        '/payments_setup': (context) => const PaymentsSetupScreen(),
      },
    );
  }
}
