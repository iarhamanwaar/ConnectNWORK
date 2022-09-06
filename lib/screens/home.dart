import 'package:connectnwork/screens/job_details.dart';
import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/job_card.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:connectnwork/widgets/toggle_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: const Drawer(
          backgroundColor: Colors.black,
        ),
        appBar: const CustomAppBar(
          title: 'Home',
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  ToggleButton(
                    icon: Icons.search,
                    text: 'Browse Jobs',
                    active: true,
                  ),
                  ToggleButton(
                    icon: Icons.calendar_month,
                    text: 'Schedule',
                    active: false,
                  ),
                  ToggleButton(
                    icon: Icons.attach_money,
                    text: 'Earnings',
                    active: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                ),
                child: Column(
                  children: const [
                    JobCard(
                      title: 'Aide Boulanger',
                      rate: 18.75,
                      vendor: 'Bridor Boucherville',
                      time: '14:30 - 22:30',
                      recurring: true,
                      location: '4455 Rue cote Marquette H2G 1R2, Laval, QC',
                      tips: true,
                      logo: 'assets/bridor_logo.png',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    JobCard(
                      title: 'Bus Boy',
                      rate: 15.75,
                      vendor: 'Mac Donald Downtown Montreal',
                      time: 'Sep 1st, 2021 18:00 - 22:30',
                      recurring: false,
                      location: '4455 Rue cote Marquette H2G 1R2, Laval, QC',
                      tips: false,
                      logo: 'assets/mcdonalds_logo.png',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    JobCard(
                      title: 'Bus Boy',
                      rate: 15.75,
                      vendor: 'Mac Donald Downtown Montreal',
                      time: 'Sep 1st, 2021 18:00 - 22:30',
                      recurring: false,
                      location: '4455 Rue cote Marquette H2G 1R2, Laval, QC',
                      tips: false,
                      logo: 'assets/mcdonalds_logo.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
