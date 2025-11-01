import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';

class ContainerWithShadow extends StatelessWidget {
  const ContainerWithShadow({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: ConsColors.orange.withValues(alpha:0.2),
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ],
      ),
      child: child,
    );
  }
}
