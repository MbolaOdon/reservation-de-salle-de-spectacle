import 'package:flutter/material.dart';

class RemoveFocuse extends StatefulWidget{
  final VoidCallback onClick;
  final Widget child;

  const RemoveFocuse({super.key, required this.onClick, required this.child});

  @override
  State<RemoveFocuse> createState() => _RemoveFocuseState();
}

class _RemoveFocuseState extends State<RemoveFocuse> {
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: widget.onClick,
      child: widget.child,
     
    );
  }
}