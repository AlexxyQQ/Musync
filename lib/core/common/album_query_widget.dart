// import 'package:flutter/material.dart';
// import 'package:musync/config/constants/constants.dart';

// class QueryArtworkFromApi extends StatelessWidget {
//   const QueryArtworkFromApi({
//     super.key,
//     required this.data,
//     required this.index,
//     this.height = 50,
//     this.width = 50,
//     this.borderRadius = const BorderRadius.all(
//       Radius.circular(50),
//     ),
//   });
//   final int index;
//   final List data;
//   final double height;
//   final double width;
//   final BorderRadius borderRadius;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: borderRadius,
//       child: Image.network(
//         data[index].albumArtUrl,
//         fit: BoxFit.cover,
//         width: width,
//         height: height,
//         errorBuilder: (
//           context,
//           error,
//           stackTrace,
//         ) =>
//             const Icon(
//           Icons.music_note_rounded,
//           color: KColors.accentColor,
//         ),
//       ),
//     );
//   }
// }
