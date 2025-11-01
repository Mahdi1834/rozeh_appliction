import 'package:flutter/material.dart';



class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    super.key, required this.color, required this.text, required this.imageUrl,
  });
  final Color color;
  final String text;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(imageUrl , width: 15 , height: 15 , color: color,),
        SizedBox(width: 10),
        Text(text , style: TextStyle(color:color , fontSize: 15),)

      ],
    );
  }
}
