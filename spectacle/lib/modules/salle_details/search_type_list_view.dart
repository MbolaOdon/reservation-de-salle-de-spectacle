import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/widgets/common_card.dart';

class SearchTypeListView extends  StatefulWidget {
   SearchTypeListView({Key? key}) : super(key : key);

   @override
  State<SearchTypeListView> createState() =>  _SearchTypeListViewState();

}

class _SearchTypeListViewState extends State<SearchTypeListView> with TickerProviderStateMixin{
  List<SalleListData> salleTypeList = SalleListData.salleTypeList;

  late AnimationController animationController;


  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
      vsync: this, duration: Duration(milliseconds: 2000)
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height * 0.2,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 0, right: 16, left:16), 
        itemCount: salleTypeList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var count = salleTypeList.length;
          var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn)
          );
          animationController.forward();
          return AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(opacity: animation,
                child: Transform(
                  transform: Matrix4.translationValues(50 * (1.0 - animation.value), 0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: deviceSize.width * 0.2,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(deviceSize.width * 0.2)),
                                boxShadow: [
                                  BoxShadow(
                                     color: Theme.of(context).dividerColor,
                                  blurRadius: 8,
                                  offset: Offset(4,4)
                                  )
                                ]
                                 
                                
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(deviceSize.width * 0.2)),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    salleTypeList[index].imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.all(Radius.circular(deviceSize.width * 0.2)),
                                highlightColor: Colors.transparent,
                                splashColor: Theme.of(context).primaryColor.withOpacity(0.4),
                                onTap: () {
                                  setState(() {
                                    salleTypeList[index].isSelected = !salleTypeList[index].isSelected;
                                  });
                                },
                                child: Opacity(
                                  opacity: salleTypeList[index].isSelected ? 1.0 : 0.0,
                                  child: CommonCard(
                                    color: Theme.of(context).primaryColor.withOpacity(0.4),
                                    radius: 48,
                                    child: SizedBox(
                                      height: deviceSize.width * 0.2,
                                      width: deviceSize.width * 0.2,
                                      child: Center(
                                        child: Icon(
                                          FontAwesomeIcons.check,
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top:4),
                          child: Text(salleTypeList[index].titleText,
                          maxLines: 2,
                          style: TextStyles(context).getBoldStyle().copyWith(fontSize: 12) //TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      );
    
  }
}