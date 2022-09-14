import 'package:connectnwork/models/my_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sanity/flutter_sanity.dart';

var sanityClient = SanityClient(
  dataset: 'production',
  projectId: '7d3rcta7',
);

final navigatorKey = GlobalKey<NavigatorState>();

final messengerKey = GlobalKey<ScaffoldMessengerState>();

late MyProfile myProfile;

const Color kBluePrimary = Color(0xFF009FE3);

const Color kOrangePrimary = Color(0xFFEF6E45);
