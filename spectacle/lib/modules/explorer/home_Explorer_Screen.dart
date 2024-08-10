import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spectacle/api/salle_service.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/modules/explorer/home_explorer_slider_view.dart';
import 'package:spectacle/modules/explorer/popular_list_view.dart';
import 'package:spectacle/modules/explorer/title_view.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/enum.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/bottom_top_move_animation_view.dart';
import 'package:spectacle/widgets/common_button.dart';
import 'package:spectacle/widgets/common_card.dart';
import 'package:spectacle/widgets/common_search_bar.dart';
import 'package:spectacle/modules/explorer/salle_liste_view_page.dart';


class HomeExplorerScreen extends StatefulWidget {
  final AnimationController animationController;
  HomeExplorerScreen({Key? key, required this.animationController}): super(key: key);

  @override
  _HomeExplorerScreenState createState() => _HomeExplorerScreenState(); 
}

class _HomeExplorerScreenState extends  State<HomeExplorerScreen> with TickerProviderStateMixin{
  late List<SalleModelClient> salleList;
  late SalleService salleService;
  

  late ScrollController controller;
  late AnimationController _animationController;
  var sliderImageHeight = 0.0;

  
  @override
  void initState(){
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 0));
    widget.animationController.forward();
    controller = ScrollController( initialScrollOffset: 0.0);
    controller.addListener(() {
      if(mounted) {
        if(controller.offset < 0) {
          _animationController.animateTo(0.0);
        }else if(controller.offset > 0.0 && controller.offset < sliderImageHeight) {
          if(controller.offset < ((sliderImageHeight / 1.5))) {
            _animationController.animateTo((controller.offset / sliderImageHeight));
          }else{
            _animationController.animateTo(((sliderImageHeight /1.5 )/ sliderImageHeight));
          }
        }
      }
    });
  
    super.initState();
    salleService = SalleService();
  }
  void getSalleList() async{
   
      salleList = await salleService.getListViewSalle();

    
  }

  @override
  Widget build(BuildContext context) {
    sliderImageHeight = MediaQuery.of(context).size.width * 1.3;
    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) =>  Stack(
        children: <Widget>[
          Container(
            color: AppTheme.scaffoldBackgroundColor,
            child: ListView.builder(
              controller: controller,
              itemCount: 4,
              padding: EdgeInsets.only(top: sliderImageHeight + 32, bottom: 16),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index){
                var count = 4;
                var animation = Tween(begin:0.0,end:1.0).animate(
                  CurvedAnimation(
                    parent:  widget.animationController,
                    curve: Curves.fastOutSlowIn),

                );
                if(index == 0) {
                  return TitleView(
                    titleText: AppLocalizations(context).of("popular_room"),
                    animationController: widget.animationController,
                    animation: animation,
                    isLeftButton: true,
                    click: () {},
                  );
                }else if(index == 1) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: PopularListView(
                      animationController: widget.animationController,
                      callBack: (index) {},
                    ),
                  );
                }else if(index == 2) {
                 return TitleView(
                    titleText: AppLocalizations(context).of("best_room"),//AppLocalization(context).of("meileur salle")
                   subText: AppLocalizations(context).of("view_all"),
                    animationController: widget.animationController,
                    animation: animation,
                    isLeftButton: true,
                    click: () {},
                  );
                }else {
                  return getDealListView(index);
                }
              }
              ),
              ),
          _sliderUI(),
          _viewSalleButton(_animationController),

          // search bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration:BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Theme.of(context).dialogBackgroundColor.withOpacity(0.4),
                    Theme.of(context).dialogBackgroundColor.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              ),
              
            ),
            
            ),
            Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 0,
                right: 0,
                child: searchUI(),
              ),
              
            
        ],
      )),
    );
  }
  
  _sliderUI() { 
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController, 
        builder: (BuildContext context, Widget? child) {
          var opacity = 1.0 - (_animationController.value > 0.64 ? 1.0 : _animationController.value);
        return SizedBox(
          height: sliderImageHeight * (1.0 - _animationController.value),
          child: HomeExplorerSliderView(
            opValue: opacity,
            click: () {},
          ),
        );
        },
        ));
  }
  
 Widget _viewSalleButton(AnimationController _animationController) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        var opecity = 1.0 -
            (_animationController.value > 0.64
                ? 1.0
                : _animationController.value);
        return Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: sliderImageHeight * (1.0 - _animationController.value),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 32,
                left: context.read<ThemeProvider>().languageType ==
                        LanguageType.ar
                    ? null
                    : 24,
                right: context.read<ThemeProvider>().languageType ==
                        LanguageType.ar
                    ? 24
                    : null,
                child: Opacity(
                  opacity: opecity,
                  child: CommonButton(
                    onTap: () {
                      if (opecity != 0) {
                        NavigationServices(context).gotoSalleHomeScreen();
                      }
                    },
                    buttonTextWidget: Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Text(
                        AppLocalizations(context).of("view_room"),
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(color: AppTheme.whiteColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  
  Widget searchUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: CommonCard(
        radius: 36,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(38)),
          onTap: () {
            NavigationServices(context).gotoSearchScreen();
          },
          child: CommonSearchBar(
            iconData: FontAwesomeIcons.magnifyingGlass,
            enabled: false,
            text: AppLocalizations(context).of("where_are_you_going"),
          ),
        ),
      ),
    );
  }

  
Widget getDealListView(int index) {
  return FutureBuilder<List<SalleModelClient>>(
    future: salleService.getListViewSalle(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Erreur : ${snapshot.error}'));
      } else {
        List<SalleModelClient> salleList = snapshot.data ?? [];
        List<Widget> list = [];
        for (var element in salleList) {
          var animation = Tween(
            begin: 0.0,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn),
          ));
          list.add(
            SalleListeViewPage(
              callback: () {
                NavigationServices(context).gotoSalleDetails(element);
              },
              salleListData: element,
              animation: animation,
              animationController: widget.animationController,
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            children: list,
          ),
        );
      }
    },
  );
}
}