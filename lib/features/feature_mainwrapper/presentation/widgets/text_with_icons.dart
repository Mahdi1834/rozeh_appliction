// import 'package:flutter/material.dart';
// import 'package:memorizing_quran/core/config/colors.dart';
//
// class textWithIcons extends StatelessWidget {
//   const textWithIcons({
//     super.key,
//     required this.imageUrl,
//     required this.text, required this.voidCallback,
//   });
//
//   final String imageUrl;
//   final String text;
//   final VoidCallback voidCallback;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap:voidCallback ,
//       child: Row(
//         children: [
//           Image.asset(
//             imageUrl,
//             width: 22,
//             height: 22,
//             color: ConsColors.grayLight,
//           ),
//           SizedBox(width: 10),
//           Expanded(
//               child: Text(
//             text,
//             style: TextStyle(
//                 color: ConsColors.blue,
//                 fontSize: 16,
//               ),
//           )),
//           Image.asset(
//             "assets/images/bottom_arrow.png",
//             width: 24,
//             height: 24,
//             color: ConsColors.blue,
//           ),
//         ],
//       ),
//     );
//   }
// }
