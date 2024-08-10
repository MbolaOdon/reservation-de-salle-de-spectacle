import 'package:flutter/material.dart';
import 'package:spectacle/utils/themes.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    super.key, required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
       width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding:  EdgeInsets.symmetric(horizontal : 8, vertical: 3),
      decoration: BoxDecoration(
      color: AppTheme.lightSecondaryBackground,
      borderRadius: BorderRadius.circular(29)
      ),
      child: child,
    );
  }
}