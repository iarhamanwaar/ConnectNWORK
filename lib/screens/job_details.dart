import 'package:connectnwork/widgets/app_bar.dart';
import 'package:connectnwork/widgets/scaffold_gradient.dart';
import 'package:flutter/material.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const ScaffoldGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomAppBar(
          title: 'Job Details',
          //drawer: false,
        ),
      ),
    );
  }
}
