import 'package:flutter/material.dart';
import 'package:spectacle/salle_app.dart';
import 'package:spectacle/modules/pages/login_page.dart';
import 'package:spectacle/modules/pages/home_page.dart';
import 'package:spectacle/modules/pages/sinup_page.dart';
import 'package:spectacle/modules/salle_booking/salle_home_screen.dart';
import 'package:spectacle/modules/salle_details/search_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return  MaterialPageRoute(builder: (_)  => ReservationApp());
      case '/login':
        return MaterialPageRoute(builder:  (_) => LoginPage());
      case '/singup':
        return MaterialPageRoute(builder:  (_) => SinupPage());
      case '/home':
        return MaterialPageRoute(builder:  (_) => HomePage());
      case '/searchScreen':
        return MaterialPageRoute(builder:  (_) => SearchScreen());
       case '/salleHomeScreen':
        return MaterialPageRoute(builder:  (_) => SalleHomeScreen());
      default:
        return _errorRoute(); 
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('Erreur'),
          )
      );
    });
  }
}