// // Queue View

// import 'package:flutter/material.dart';
// import 'package:musync/utils/colors.dart';

// class QueueView extends StatelessWidget {
//   const QueueView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.5,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         color: isDark ? offBlackColor : offWhiteColor,
//       ),
//     );
//   }
// }
