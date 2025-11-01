import 'package:flutter/material.dart';
import 'package:rozeh_project/core/widgets/card_for_bottom_sheet.dart';

void showFancyBottomSheet({
  required BuildContext context,
  required Widget child,


}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,

    builder: (context) {
      final width = MediaQuery.of(context).size.width;

      return Padding(
        padding: EdgeInsets.only(
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: SizedBox(
            width: width,
            child: CardForBottomSheet(

              onPressed: () {
                print("Closing...");
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 8.0),
                child: child,
              ),
            ),
          ),
        ),
      );
    },
  );
}
