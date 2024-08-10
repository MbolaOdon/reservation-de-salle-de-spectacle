import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/modules/client/client_screen.dart';
import 'package:spectacle/modules/explorer/home_Explorer_Screen.dart';
import 'package:spectacle/modules/pages/components/tab_button_ui.dart';
import 'package:spectacle/modules/proprietaire/proprietaire_screen.dart';
import 'package:spectacle/modules/proprietaire/reservation_screen.dart';
import 'package:spectacle/providers/secure_storage.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/modules/profile/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:spectacle/widgets/common_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isFirstTime = true;
  BottomBarType bottomBarType = BottomBarType.Explore;
  Widget _indexView = Container();
  final SecureStorage secureStorage = SecureStorage();
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
 // Map<String, dynamic>? retrievedData = await secureStorage.getJsonData('user_data');

  @override
  void initState() {
    super.initState();
     WidgetsFlutterBinding.ensureInitialized();
    _animationController = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startLoadingScreen();
    });
  }

  Future<void> _startLoadingScreen() async {
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      _isFirstTime = false;
      _indexView = HomeExplorerScreen(animationController: _animationController);
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.backgroundColor,
//       bottomNavigationBar: CurvedNavigationBar(
//         height: 65.0,
//         key: _bottomNavigationKey,
//         index: 0,
//         items: <Widget>[
//           Icon(Icons.home, key: Key('home'), size: 18, color: Colors.white),
//           Icon(Icons.list, key: Key('gestion'), size: 18, color: Colors.white),
//           //retrievedData?['role'] == "prop" ? 
//            Icon(Icons.report_rounded ,key: Key('reservation'), size: 18, color: Colors.white) ,
//           Icon(Icons.perm_identity, key: Key('profile'), size: 18, color: Colors.white),
          
    
//         ],
//         color: AppTheme.primaryColor,
//         buttonBackgroundColor: AppTheme.primaryColor,
//         backgroundColor: Colors.transparent,
//         animationCurve: Curves.easeInOut,
//         animationDuration: Duration(milliseconds: 600),
//         onTap: (index) {
//           setState(() {
//             tabClick(BottomBarType.values[index]);
//           });
//         },
//         letIndexChange: (index) => true,
//       ),
//       body: _isFirstTime
//           ? Center(child: CircularProgressIndicator(strokeWidth: 2))
//           : _indexView,
//     );
//   }

//   void tabClick(BottomBarType tabType) {
//     if (tabType != bottomBarType) {
//       bottomBarType = tabType;
//       _animationController.reverse().then((value) async {
//         setState(() {
//           if (tabType == BottomBarType.Explore) {
//             _indexView = HomeExplorerScreen(animationController: _animationController);
//           } else if (tabType == BottomBarType.Trips) {
//             _loadUserSpecificScreen();
//           } else if (tabType == BottomBarType.Profile) {
//             _indexView = ProfileScreen(animationController: _animationController);
//           }
//           else if (tabType == BottomBarType.reservation) {
//             _indexView = ReservationScreen(animationController: _animationController);
//           }
//         });
//         _animationController.forward();
//       });
//     }
//   }

//   Future<void> _loadUserSpecificScreen() async {
//     Map<String, dynamic>? retrievedData = await secureStorage.getJsonData('user_data');
//     if (retrievedData != null && retrievedData['role'] == "prop") {
//        setState(() {
//       _indexView = ProprietaireScreen(animationController: _animationController);
//        });
//       print(retrievedData);
//     } else {
//       setState(() {
//          _indexView = ClientScreen(animationController: _animationController);
//       });
     
//     }
//   }
// }

// enum BottomBarType { Explore, Trips,reservation, Profile }

 @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, provider, child) => Container(
        child: Scaffold(
          bottomNavigationBar: Container(
              height: 60 + MediaQuery.of(context).padding.bottom,
              child: getBottomBarUI(bottomBarType)),
          body: _isFirstTime
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : _indexView,
        ),
      ),
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      _animationController.reverse().then((f) {
        if (tabType == BottomBarType.Explore) {
          setState(() {
            _indexView = HomeExplorerScreen(
              animationController: _animationController,
            );
          });
        } else if (tabType == BottomBarType.Trips) {
         _loadUserSpecificScreen();
             
          
        } else if (tabType == BottomBarType.Profile) {
          setState(() {
            _indexView = ProfileScreen(
              animationController: _animationController,
            );
          });
        } else if (tabType == BottomBarType.Reservation) {
          setState(() {
            _indexView = ReservationScreen(
              animationController: _animationController,
            );
          });
        }
      });
    }
  }
  Future<void> _loadUserSpecificScreen() async {
    Map<String, dynamic>? retrievedData = await secureStorage.getJsonData('user_data');
    if (retrievedData != null && retrievedData['role'] == "prop") {
       setState(() {
      _indexView = ProprietaireScreen(animationController: _animationController);
       });
      print(retrievedData);
    } else {
      setState(() {
         _indexView = ClientScreen(animationController: _animationController);
      });
     
    }
  }
  Widget getBottomBarUI(BottomBarType tabType) {
    return CommonCard(
      color: AppTheme.backgroundColor,
      radius: 0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TabButtonUI(
                icon: Icons.home,
                isSelected: tabType == BottomBarType.Explore,
                text: AppLocalizations(context).of("explore"),
                onTap: () {
                  tabClick(BottomBarType.Explore);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.building,
                isSelected: tabType == BottomBarType.Trips,
                text: "Salle",//AppLocalizations(context).of("room_text"),
                onTap: () {
                  tabClick(BottomBarType.Trips);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.registered,
                isSelected: tabType == BottomBarType.Reservation,
                text: "Reservation",//AppLocalizations(context).of("reservation"),
                onTap: () {
                  tabClick(BottomBarType.Reservation);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.user,
                isSelected: tabType == BottomBarType.Profile,
                text: AppLocalizations(context).of("profile"),
                onTap: () {
                  tabClick(BottomBarType.Profile);
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}


enum BottomBarType { Explore, Trips,Reservation, Profile }
