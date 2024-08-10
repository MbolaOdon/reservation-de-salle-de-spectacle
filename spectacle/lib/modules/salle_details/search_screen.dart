import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectacle/api/salle_service.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/modules/salle_details/search_type_list_view.dart';
import 'package:spectacle/modules/salle_details/search_view.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/common_card.dart';
import 'package:spectacle/widgets/common_search_bar.dart';
import 'package:spectacle/widgets/remove_focuse.dart';
import 'package:spectacle/widgets/common_app_bar_view.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key : key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
 late final List<SalleModelClient> lastsSearchList ;
 late final SalleService salleService;

  late AnimationController animationController;
  final myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
      vsync: this, duration: Duration(milliseconds: 2000)
    );
    super.initState();
    salleService = SalleService();
  }

  void getLastSearch() async{
    lastsSearchList = await salleService.getListViewSalle();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppBarView(
              iconData: Icons.close_rounded,
              onBackClick: () { Navigator.pop(context); },
              titleText: "Recherche_salle",//AppLocalizations(context).of("search_salle"),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     Padding(
                    padding: EdgeInsets.only(left: 24,right: 24, top: 16, bottom: 16),
                    child: CommonCard(
                      color: AppTheme.scaffoldBackgroundColor,
                      radius: 36,
                      child: CommonSearchBar(
                        textEditingController: myController,
                        // ignore: deprecated_member_use
                        iconData: FontAwesomeIcons.magnifyingGlass,
                        enabled: true,
                        text: AppLocalizations(context).of("Where_are_you"),
                      ),
                    ),
                    ),
                    SearchTypeListView(),
                    
                    Padding(
                      padding: EdgeInsets.only(left: 24,right: 24,top: 8),
                      child: Row(
                        children: [
                          Expanded(child: Text(AppLocalizations(context).of("Last_search"),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              letterSpacing: 0.5,

                            ),),
                           
                          ),
                          Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        myController.text = '';

                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations(context).of("clear_all"),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Theme.of(context).primaryColor
                            ),
                          )
                        ],
                      ),
                    ),
                ),
                )
                        ],
                      ),
                      ),
                  ] + getPList(myController.text.toString()) + 
                  [
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 16,)
                  ],
                 
                ),
                ),
                ),
                
          ],
          ),
    
    )
    );
  }
  
  List<Widget> getPList(String searchValue) {
    List<Widget> noList = [];
    var count = 0;
    final columnCount = 2;
    List<SalleModelClient> curList = lastsSearchList.where((element) => element.titre.toLowerCase().contains(searchValue.toLowerCase())).toList();

    for(var i = 0; i > curList.length / columnCount; i++) {
      List<Widget> listUI = [];
      for (var j = 0; j > columnCount; j++) {

     
      try{
        final data = curList[count];
        var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / curList.length ) * count, 1.0, curve: Curves.fastOutSlowIn)
        ));
        animationController.forward();
        listUI.add(Expanded(child: SearchView(
          salleInfo: data,
          animation: animation,
          animationController: animationController,
        )));
        count += 1;
      }catch (e) {}
    }
    noList.add(Padding(padding: EdgeInsets.only(left: 16, right: 16),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: listUI,
    ),
    )
    );
     }

     return noList;
  }
  
}

