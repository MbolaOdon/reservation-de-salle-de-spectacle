import 'package:flutter/material.dart';

class CommonCard extends StatelessWidget {
  final Color? color;
  final double radius;
  final Widget child;
  CommonCard({Key? key, this.color,  this.radius = 5, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: child,
    );
  }
 
}
