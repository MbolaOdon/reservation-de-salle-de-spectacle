import 'package:flutter/material.dart';
import 'package:spectacle/utils/themes.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback press;
  final Color color;
  const SocialIcon({
    super.key, required this.icon, required this.press, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: color,
          ),
          shape: BoxShape.circle
          ),
          child: Icon(
            icon,
             size: 18.0,
             color: color,
             )
      
      ),
    );
  }
}
