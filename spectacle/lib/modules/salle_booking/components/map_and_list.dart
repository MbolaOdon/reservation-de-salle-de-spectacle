import 'package:flutter/material.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/modules/salle_booking/components/google_map_ui_view.dart';
import 'package:spectacle/modules/salle_booking/components/time_date_view.dart';
import 'package:spectacle/modules/salle_booking/map_salle_view.dart';
import 'package:spectacle/routes/route_names.dart';

class MapAndListView extends StatelessWidget {
  final List<SalleModelClient> salleList;
  final Widget searchBarUI;

  const MapAndListView({Key? key, required this.salleList, required this.searchBarUI}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StatefulBuilder(
        builder: (context, state) {
          return Column(
            children: [
            searchBarUI,
            TimeDateView(),
            Expanded(child: Stack(
              children: [
                GoogleMapUIView(salleList: salleList),
                IgnorePointer(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).scaffoldBackgroundColor.withOpacity(1.0),
                          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                        ], 
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        )
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 156,
                    child: ListView.builder(
                      itemCount: salleList.length,
                      padding: EdgeInsets.only(top: 8,bottom: 8, right: 16),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MapSalleListView(callback: (){
                          NavigationServices(context).gotoSalleBookingScreen(salleList[index].titre);
                        },salleListData: salleList[index],)
                        ;}
                    ),
                ))
              ],
            ))
          ],);
        }),
    );
  }
}