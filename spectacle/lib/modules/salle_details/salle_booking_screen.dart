import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectacle/api/salle_service.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/modules/salle_details/salle_booking_view.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/utils/enum.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:http/http.dart' as http;
import 'package:spectacle/config/config.dart';

class SalleBookingScreen extends StatefulWidget {
  final String SalleName;

  SalleBookingScreen({Key? key, required this.SalleName}) : super(key: key);

  @override
  State<SalleBookingScreen> createState() => _SalleBookingScreenState();
}

class _SalleBookingScreenState extends State<SalleBookingScreen>
    with TickerProviderStateMixin {
  //List<SalleListData> salleList = SalleListData.salleList;
  List<SalleModel> salleListe = SalleModel.salleList;
  late AnimationController animationController;
  late List<SalleModelClient> salleList;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
    salleList = [];
    fetchSalle();
  }

  void fetchSalle() async {
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
          salleList = decodedData
              .map((json) => SalleModelClient.fromJson(json))
              .toList();
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          getAppBarUI(),
          Expanded(
           child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: salleList.length,
              itemBuilder: (context, index) {
                var count = salleList.length > 10 ? 10 : salleList.length;
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animationController,
                        curve: Interval((1 / count) * index, 1.0,
                            curve: Curves.fastOutSlowIn)));
                animationController.forward();

                return SalleBookingView(
                  salleData: salleList[index],
                  animationController: animationController,
                  animation: animation,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 16,
          right: 16,
          bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                widget.SalleName,
                style: TextStyles(context).getTitleStyle(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Material(
              color: Colors.transparent,
              child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.favorite_border),
                  ))),
        ],
      ),
    );
  }
}