
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rozeh_project/core/config/colors.dart';

class DotLoadingWidget extends StatelessWidget {
  final double size;
  final Color ? color ;
  const DotLoadingWidget({super.key,required this.size, this.color = ConsColors.green});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          size: size,
          color: color! ,
        ),
      ),
    );
  }
}
