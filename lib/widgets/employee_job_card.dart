// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:connectnwork/constants.dart';
// import 'package:connectnwork/models/employee_job_model.dart';
// import 'package:connectnwork/screens/job_details.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
//
// class EmployeeJobCard extends StatelessWidget {
//   final EmployeeJob job;
//   final bool detailed;
//   final bool hired;
//   final bool inProgress;
//   final bool completed;
//   final bool pending;
//   final bool cancelled;
//   final bool cancelledByEmployer;
//   final bool dateWithTime;
//
//   const EmployeeJobCard({
//     Key? key,
//     required this.job,
//     this.detailed = false,
//     this.hired = false,
//     this.inProgress = false,
//     this.completed = false,
//     this.pending = false,
//     this.cancelled = false,
//     this.cancelledByEmployer = false,
//     this.dateWithTime = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final String title = job.job!.title!;
//     final double rate = job.shift!.ratePerHr!;
//     final String vendor = job.job!.employer!.name!;
//     final String time;
//     String startTime = DateFormat.Hm().format(job.shift!.startTime!.toLocal());
//     String endTime = DateFormat.Hm().format(job.shift!.endTime!.toLocal());
//
//     if (dateWithTime) {
//       String date = DateFormat.yMMMMd().format(job.shift!.startTime!.toLocal());
//       time = '$date $startTime - $endTime';
//     } else {
//       time = '$startTime - $endTime';
//     }
//     final String logo = job.job!.employer!.logo!;
//     final String location = job.job!.location!.formattedAddress!;
//     final bool tips = job.shift!.tip!;
//     final bool recurring = job.shift!.days!.length > 1 ? true : false;
//
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => JobDetailsScreen(
//               job: job,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF000000).withOpacity(0.05),
//               blurRadius: 30,
//               offset: const Offset(0, 20),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               height: 100,
//               padding: const EdgeInsets.only(
//                 top: 15,
//                 left: 13,
//                 right: 30,
//               ),
//               child: Stack(
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 14,
//                     ),
//                   ),
//                   Positioned(
//                     top: 30,
//                     child: Text(
//                       '\$$rate/hr',
//                       style: tips
//                           ? GoogleFonts.montserrat(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 1.5,
//                             )
//                           : const TextStyle(
//                               fontSize: 14,
//                             ),
//                     ),
//                   ),
//                   tips
//                       ? Positioned(
//                           top: 23,
//                           left: 80,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.black),
//                               color: const Color(0xFFFFF2D2),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 9,
//                               vertical: 4,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 '+ Tips',
//                                 style: GoogleFonts.montserrat(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       : Container(),
//                   Positioned(
//                     top: 55,
//                     child: Text(
//                       vendor,
//                       style: GoogleFonts.montserrat(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         height: 1.5,
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: SizedBox(
//                       height: 65,
//                       width: 65,
//                       child: CachedNetworkImage(
//                         imageUrl: logo,
//                         errorWidget: (context, url, error) => const Icon(Icons.error),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(
//               thickness: 1,
//               height: 1,
//               color: Color(0xFFDADADA),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             detailed
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           left: 21,
//                           right: 21,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(
//                                   Icons.schedule,
//                                   size: 16,
//                                   color: kOrangePrimary,
//                                 ),
//                                 const SizedBox(
//                                   width: 8,
//                                 ),
//                                 Text(
//                                   time,
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     color: kOrangePrimary,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             SizedBox(
//                               height: 80,
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: job.shift!.days!.length,
//                                 itemBuilder: (context, index) {
//                                   return Text(
//                                     DateFormat.yMMMMEEEEd().format(job.shift!.days![index]),
//                                     style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       letterSpacing: 2,
//                                       height: 1.8,
//                                       color: kOrangePrimary,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Divider(
//                         thickness: 1,
//                         height: 1,
//                         color: Color(0xFFDADADA),
//                       ),
//                     ],
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.only(left: 20.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: const Color(0xFF000000).withOpacity(0.25),
//                             blurRadius: 4,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       padding: const EdgeInsets.only(
//                         top: 5,
//                         bottom: 5,
//                         left: 10,
//                         right: 14,
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             Icons.schedule,
//                             size: 16,
//                             color: recurring ? kOrangePrimary : kBluePrimary,
//                           ),
//                           const SizedBox(
//                             width: 8,
//                           ),
//                           Text(
//                             recurring ? '$time Recurring days' : time,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: recurring ? kOrangePrimary : kBluePrimary,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//             const SizedBox(
//               height: 15,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     const Icon(
//                       Icons.place_outlined,
//                       size: 20,
//                       color: Color(0xFF77838F),
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     SizedBox(
//                       width: 150,
//                       child: Text(
//                         location,
//                         style: const TextStyle(
//                           color: Color(0xFF77838F),
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (hired)
//                   Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF3DD598).withOpacity(0.1),
//                         ),
//                         child: const Center(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 24.0,
//                               vertical: 3,
//                             ),
//                             child: Text(
//                               'Hired',
//                               style: TextStyle(
//                                 color: Color(0xFF049B13),
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                     ],
//                   ),
//                 if (inProgress)
//                   Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFFF974A).withOpacity(0.1),
//                         ),
//                         child: const Center(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 24.0,
//                               vertical: 3,
//                             ),
//                             child: Text(
//                               'Shift in Progress',
//                               style: TextStyle(
//                                 color: Color(0xFFFF974A),
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                     ],
//                   ),
//                 if (completed)
//                   Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF3DD598).withOpacity(0.1),
//                         ),
//                         child: const Center(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 24.0,
//                               vertical: 3,
//                             ),
//                             child: Text(
//                               'Completed',
//                               style: TextStyle(
//                                 color: Color(0xFF3DD598),
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                     ],
//                   ),
//                 if (pending)
//                   Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF50B5FF).withOpacity(0.1),
//                         ),
//                         child: const Center(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 24.0,
//                               vertical: 3,
//                             ),
//                             child: Text(
//                               'Pending',
//                               style: TextStyle(
//                                 color: Color(0xFF50B5FF),
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                     ],
//                   ),
//                 if (cancelled)
//                   Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFFC5A5A).withOpacity(0.1),
//                         ),
//                         child: const Center(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 24.0,
//                               vertical: 3,
//                             ),
//                             child: Text(
//                               'Cancelled',
//                               style: TextStyle(
//                                 color: Color(0xFFFC5A5A),
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                     ],
//                   ),
//                 if (cancelledByEmployer)
//                   Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFFC5A5A).withOpacity(0.1),
//                         ),
//                         child: const Center(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 24.0,
//                               vertical: 3,
//                             ),
//                             child: Text(
//                               'Cancelled by\nEmployer',
//                               style: TextStyle(
//                                 color: Color(0xFFFC5A5A),
//                                 fontSize: 14,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
