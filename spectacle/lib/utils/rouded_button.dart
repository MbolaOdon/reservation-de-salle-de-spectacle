import 'package:flutter/material.dart';

class RoudedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  const RoudedButton({
    super.key, required this.text, required this.press, this.color = Colors.orange, required this.textColor,
    
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      color: color,
      child: ClipRect(
      
        child: TextButton(
          onPressed:  press ,
          child: Text(
            text,
          style: TextStyle(color: textColor,),
        ),)
      ),
    );
  }
}






