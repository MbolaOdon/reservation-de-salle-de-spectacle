import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;

  const CustomToast({
    Key? key,
    required this.message,
    required this.icon,
    this.backgroundColor = Colors.black87,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 12.0),
          Text(
            message,
            style: TextStyle(color: Colors.white, fontSize:12),
          ),
        ],
      ),
    );
  }
}