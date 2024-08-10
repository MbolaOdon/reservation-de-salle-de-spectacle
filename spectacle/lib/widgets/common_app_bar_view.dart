import 'package:flutter/material.dart';

class CommonAppBarView extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onBackClick;
  final String titleText;

  const CommonAppBarView({
    Key? key,
    required this.iconData,
    required this.onBackClick,
    required this.titleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(iconData),
        onPressed: onBackClick,
      ),
      title: Text(titleText),
      centerTitle: true,
    );
  }


}