import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spectacle/config/config.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/modules/salle_booking/components/filter_bar_UI.dart';
import 'package:spectacle/modules/salle_booking/components/map_and_list.dart';
import 'package:spectacle/modules/salle_booking/components/time_date_view.dart';
import 'package:spectacle/modules/client/salle_list_view.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/enum.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/common_card.dart';
import 'package:spectacle/widgets/common_search_bar.dart';
import 'package:spectacle/widgets/remove_focuse.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class SalleHomeScreen extends StatefulWidget {
  SalleHomeScreen({Key? key}) : super(key : key);

  @override
  State<SalleHomeScreen>createState() => _SalleHomeScreenState();

}

class _SalleHomeScreenState extends State<SalleHomeScreen> with TickerProviderStateMixin{
  
  late AnimationController animationController;
  late AnimationController _animationController;
  //var salleList = SalleListData.salleList;
  ScrollController scrollController = new ScrollController();

  int place = 1;
  int add =2;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 5));

  bool _isShowMap = false;

  final searchBarHeight = 158.0;
  final filterBarHeight = 52.0;

  late List<SalleModelClient>salleList;

  @override
  void initState() {
     animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 0));
   
    scrollController.
   addListener(() {
     
        if(scrollController.offset <= 0) {
          _animationController.animateTo(0.0);
        }else if(scrollController.offset > 0.0 && 
        scrollController.offset < searchBarHeight) {
         
            _animationController.animateTo(((scrollController.offset /1.5 )/ searchBarHeight));
        }else{
          _animationController.animateTo(1.0);
        }
        
    
    });
    salleList = [];
    fetchSalle();
    super.initState();
  }
  
  Future<bool> getData() async {
    await Future.delayed(Duration(milliseconds: 200));
    return true;
  }
  void fetchSalle() async{
     String uri = "${Config.BaseApiUrl}/salleController/getViewSalle";
  try {
    var response = await http.get(Uri.parse(uri));
    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      String responseBody = response.body;
      if (responseBody.contains("SalleController")) {
        responseBody = responseBody.substring(responseBody.indexOf('['));
      }
      List<dynamic> decodedData = jsonDecode(responseBody);
      setState(() {
        salleList = decodedData.map((json) => SalleModelClient.fromJson(json)).toList();
        //isLoading = false;
      });
    }
  } catch (e) {
    print("Error: $e");
    setState(() {
      //isLoading = false;
    });
  }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      body: Stack(
        children: [
          RemoveFocuse(
            onClick: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                _getAppBarUI(),
                _isShowMap
                  ? MapAndListView(
                    salleList: salleList,
                    searchBarUI: _getSearchBarUI(),
                  )
                  : 
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        color: AppTheme.scaffoldBackgroundColor,
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: salleList.length,
                          padding: EdgeInsets.only(top: 8 + 158 + 52.0,),
                          itemBuilder: (context, index) {
                            var count = salleList.length > 10 ? 10 : salleList.length;
                            var animation = Tween(begin: 0.0,end: 1.00).animate(
                              CurvedAnimation(
                                parent: animationController, 
                                curve: Interval((1 / count) * index, 1.0, 
                                curve: Curves.fastOutSlowIn)
                              )
                            );
                            animationController.forward();
                            return SalleListView(
                              callback: (){
                                NavigationServices(context).gotoSalleBookingScreen(salleList[index].titre);
                              },
                              salleListData: salleList[index],
                              animation: animation,
                              animationController: animationController,
                               );
                          }
                        
                        )

                      ),
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (BuildContext context, Widget? child) {
                          return Positioned(
                            top: -searchBarHeight * (_animationController.value),
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                               Container(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                child: Column(
                                  children: [
                                    _getSearchBarUI(),
                                     TimeDateView(),
                                  ],
                                ),
                                ),
                                FilterBarUI(foundSalle: salleList.length,),

                               // time date salle view
                              
                              ],
                            ),
                          );
                        }
                        )
                    ],
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  } 

  Widget _getAppBarUI() {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 8, right: 8
        ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
             alignment: context.read<ThemeProvider>().languageType == LanguageType.ar 
            ? Alignment.centerRight
            : Alignment.centerLeft,
            width: AppBar().preferredSize.height + 40,
            height: AppBar().preferredSize.height,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back, color: Colors.black,),
                  ),
              )
            ),

          ),
          Expanded(
            child: Center(
              child: Text(
                AppLocalizations(context).of("explore"),
                style: TextStyles(context).getTitleStyle(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
            width: AppBar().preferredSize.height +40,
            height: AppBar().preferredSize.height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                    onTap: () {
                      setState(() {
                        _isShowMap = !_isShowMap;
                      });
                    },
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(_isShowMap ? Icons.sort : FontAwesomeIcons.mapLocationDot),
                      )
                  )
                )
              ],
            ),
          )
        ],
      ),
      );
  }

  Widget _getSearchBarUI() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 16, top: 8, ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(0),
              child: CommonCard(
                color: Color.fromARGB(253, 255, 255, 255),
                radius: 36,
                child: CommonSearchBar(
                  enabled: true,
                  isShow: false,
                  text: "Londre...",
                  
                ),
              ),
            ),
          ),
          CommonCard(
                color: AppTheme.primaryColor,
                radius: 36,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      NavigationServices(context).gotoSearchScreen();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 20,
                        color:  AppTheme.backgroundColor
                      ),
                    ),
                  )
                ),
                )
        ],
      ),
      );
  }
}