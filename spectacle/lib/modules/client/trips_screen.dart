import 'package:flutter/material.dart';

class TripsScreen extends StatefulWidget {
  final AnimationController animationController;
  TripsScreen({Key? key, required this.animationController}) : super(key: key);

  @override
  _TripsScreenState createState() => _TripsScreenState();

}

class _TripsScreenState extends State<TripsScreen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Center(
        child: Text("Trips Exporateur"),
      ),
    );
  }
}