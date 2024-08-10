import 'package:flutter/material.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/popular_filter_list.dart';
import 'package:spectacle/modules/salle_booking/filter_screen/range_slider_view.dart';
import 'package:spectacle/modules/salle_booking/filter_screen/slider_view.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/common_app_bar_view.dart';
import 'package:flutter/cupertino.dart';

class FiltersScreen extends StatefulWidget {
  FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState()=> _FiltersScreenState(); 
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<PopularFilterListData> popularFilterListData = PopularFilterListData.popularFList;
  List<PopularFilterListData> accomodationListData = PopularFilterListData.popularFList;

  RangeValues _values = RangeValues(100, 600);
  double distValues = 50.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.scaffoldBackgroundColor,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonAppBarView(
              iconData: Icons.close,
              onBackClick: (){
                Navigator.pop(context);
              },
              titleText: AppLocalizations(context).of("filter"),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [

                      priceBarFilter(),
                      Divider(
                        height:1,
                      ),

                      popularFilter(),

                       Divider(
                        height:1,
                      ),

                      distanceViewUI(),

                      Divider(
                        height:1,
                      ),

                      allAccommodationUI(),

                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );

  }

  Widget priceBarFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            AppLocalizations(context).of("price_text"),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey, 
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal),
          ),
        ),
        RangeSliderView(
          values: _values,
          onChangeRangeValues: (values) {
            _values = values;
          },
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget popularFilter(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8),
          child: Text(
            AppLocalizations(context).of("popular_filter"),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
              ),

          ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16, left: 16),
            child: Column(
              children: getPList(),
            )
          )
      ],
      );
  }
  
  List<Widget> getPList() {
    List<Widget> noList = [];
    var count = 0;
    final columnCount = 2;

    for(var i = 0; i < popularFilterListData.length / columnCount; i++) {
      List<Widget> listUI = [];
      for(var j = 0; j < columnCount; j++) {
        try{
          final data = popularFilterListData[count];
          listUI.add(
            Expanded(child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    onTap: (){
                      setState(() {
                        data.isSelected = !data.isSelected;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0,top:8.0, bottom: 8,right:0),
                      child: Row(
                        children: [
                          Icon(
                            data.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                            color: data.isSelected ? Theme.of(context).primaryColor :  Colors.grey.withOpacity(0.6),
                          ),
                          SizedBox(
                            width:4,
                          ),
                          FittedBox(
                            fit: BoxFit.cover,
                            child: Text(AppLocalizations(context).of(data.titleText)),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),)
          );
          count +=1;
        }catch (e){}
      }
      noList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: listUI,
        )
      );
    }
    return noList;
  }
  
  Widget distanceViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        child: Text(
          AppLocalizations(context).of("distance_from_city"),
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.grey,
            fontSize:MediaQuery.of(context).size.width > 360 ? 18 : 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        ),
        SliderView(
          onChangeDistValue: (value) {
            distValues= value;
          },
          distValue: distValues,
        )
      ],
    );
  }

  Widget allAccommodationUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children : [
        Padding(
          padding :EdgeInsets.only(left: 16, right: 16,),
          child: Text(
            AppLocalizations(context).of('type_of_accommodation'),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: getAccommodationListUI(),
        ),
        ),
        SizedBox(
          height: 8,
        )
      ]
    );
  }

  List<Widget> getAccommodationListUI() {
    List<Widget> noList = [];
    for(var i= 0; i< accomodationListData.length; i++) {
      final data = accomodationListData[i];
      noList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            onTap: (){
              setState(() {
                checkAppPosition(i);
              });
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(AppLocalizations(context).of(data.titleText)),
                  ),
                  CupertinoSwitch(
                    value: data.isSelected,
                    onChanged: (value) {
                      setState(() {
                        checkAppPosition(i);
                      });
                    },
                    activeColor: data.isSelected ? Theme.of(context).primaryColor : Colors.grey.withOpacity(0.6),
                    )
                ],
              )
            ),
          )
        )
      );
      if(i == 0){
        noList.add(Divider(height: 1));
      }
     
    }
     return noList;
  }

  void checkAppPosition(int index) {
    if(index == 0){
      if(accomodationListData[0].isSelected){
        accomodationListData.forEach((d){
          d.isSelected = false;
        });
      }else {
        accomodationListData.forEach((d) {
          d.isSelected = true;
        });
      }
    }else {
      accomodationListData[index].isSelected = !accomodationListData[index].isSelected;

      var count =0;
      for(var i = 0; i < accomodationListData.length; i++){
        if(i != 0){
          var data = accomodationListData[i];
          if(data.isSelected){
            count +=1;
          }
        }
      }

      if(count == accomodationListData.length - 1){
        accomodationListData[0].isSelected = true;
      }else {
        accomodationListData[0].isSelected = false;
      }
    }
  }
}