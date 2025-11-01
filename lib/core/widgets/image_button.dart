import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    super.key,
    required this.url,
    required this.voidCallback,
  });

  final String url;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: Image.asset(
        url,
        width: 35,
        height: 35,
      ),
    );
  }
}
