import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/salle_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(_setAllProviders()));
}

Widget _setAllProviders() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(
          state: AppTheme.getThemeData,
        ),
      ),
    ],
    child: ReservationApp(),
  );
}
//02:23:08
/// 54:04
/// 00:27:45
/// 
/// install GoogleMapProvider,  CupertinoSwitch
/// github.com/Punithraaj/Flutter_Hotel_Booking_UI/blob/Episode-7/

















// import 'package:flutter/material.dart';
// import 'package:spectacle/routes/route_generator.dart';


// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
    
//     home: ReservationApp(),
//     initialRoute: '/',
//     onGenerateRoute: RouteGenerator.generateRoute,
//   ));
// }

// void goToApp(){
//  // 1:05:46 stopped 07:35
//  // add   shared_preferences  ,  google_fonts   ,  google_map_flutter  ,   provider  ,  flutter_rating_bar  ,  rating_bar_indicator ,  
// }

// class ReservationApp extends StatefulWidget {
//   @override
//   _ReservationAppState createState() => _ReservationAppState();

// }

// class _ReservationAppState extends State<ReservationApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       backgroundColor: Color.fromARGB(255, 255, 255, 255),

//      body: 
     
//      Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/images/bghome.jpg'),
//            fit: BoxFit.cover,
//         )
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      
//       child : Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
        
//         children: [
//           Container(
//              padding:EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0, right: 50.0),
//             child: Icon(Icons.home_repair_service,color: Colors.orange),
//            height: 70.0,
//                 width: 70.0,
//                 decoration: BoxDecoration(
//                   boxShadow: [BoxShadow(
//                     offset: Offset(0.0, 10.0),
//                     blurRadius: 30.0, 
//                     color: Colors.white)], 
//                   color: Color.fromARGB(255, 255, 255, 255),
//                   borderRadius: BorderRadius.circular(22.0)
//                 ),
                
//           ),
//           SizedBox(
//             height:50.0
//           ),
//           Text('Bienvenue sur ReservApp',
//             style: TextStyle(
//               color: Color.fromARGB(255, 253, 135, 61),
//               fontSize: 22.0,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           Text("Nous avons les meilleurs salles pour votre spectacle",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16.0,
//             fontWeight: FontWeight.w500,
//             fontStyle: FontStyle.italic
            
//           )
//           ),
//           SizedBox(
//             height:  180.0,
//           ),
//           Center(
            
//             child: InkWell(
//               onTap: () {
//                 Navigator.of(context).pushNamed('/login');
//               },
//               child: Container(
//                 height: 50.0,
//                 width: 250.0,
//                 decoration: BoxDecoration(
//                   boxShadow: [BoxShadow(
//                     offset: Offset(0.0, 20.0),
//                     blurRadius: 30.0, 
//                     color: Colors.black12)], 
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(22.0)
                  
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     Container(
                      
//                       width: 190.0,
//                       padding: EdgeInsets.symmetric(
//                         vertical: 12.0, horizontal: 20.0
//                       ),
//                       child: Text('Commencer',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16.0,
//                       ),
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 255, 122, 34),
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(90.0),
//                           topLeft:  Radius.circular(90.0),
//                           bottomRight: Radius.circular(200.0)
//                         )
//                       ),
//                 ),
//                 Icon(
//                   Icons.arrow_forward,
//                    size: 20.0,
//                    color: Color.fromARGB(255, 253, 135, 61),
//                 )
//                   ] 
//                 ),
                
//               ),
//             ),
//           )
          
           
//         ],)
      
  
//      )
//     );
//   }
// }

