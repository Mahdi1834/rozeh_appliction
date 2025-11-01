import 'package:flutter/material.dart';

import 'package:rozeh_project/core/widgets/fancy_card_down.dart';

class CardWithWidgetInDip extends StatelessWidget {
  final Widget child;
  final Widget childBtn;


  const CardWithWidgetInDip({
    super.key,
    required this.child,
    required this.childBtn,

  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: width,
          child: FancyCardDown(dipWidth: width * 0.8, child: child),
        ),
        Positioned(
          bottom: -15,
          child: SizedBox(
            width: width * 0.75,
            child: childBtn
          ),
        ),
      ],
    );
  }
}
