// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// class LenseLoadingAnimation extends StatelessWidget {
//   const LenseLoadingAnimation({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: const CustomPaint(
//             painter: LenseLoadingPainter extends CustomPainter(),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class LenseLoadingPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint =Paint()
//         ..color = Colors.yellow
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 3;
//
//     Rect rect = Rect.fr(center: Offset(dx, dy), radius: 20);
//
//     canvas.drawArc(rect, 0, pi * 2, true, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
//
// }
