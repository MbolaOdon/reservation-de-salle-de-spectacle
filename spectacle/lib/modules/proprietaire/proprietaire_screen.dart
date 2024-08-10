import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectacle/config/config.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/modules/proprietaire/salle_item.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/localfiles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/widgets/common_card.dart';
import 'package:spectacle/widgets/common_search_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProprietaireScreen extends StatefulWidget {
  final AnimationController animationController;
  ProprietaireScreen({Key? key, required this.animationController}) : super(key: key);

  @override
  State<ProprietaireScreen> createState() => _ProprietaireScreenState();
}

class _ProprietaireScreenState extends State<ProprietaireScreen> with TickerProviderStateMixin, WidgetsBindingObserver {
  final myController = TextEditingController();
  List<SalleModel> userdata = [];
  bool isLoading = true;

  @override
  void initState() {
    
    widget.animationController.forward();
    super.initState();
    fetchData();
     WidgetsBinding.instance.addObserver(this);
     
    WidgetsBinding.instance.addPostFrameCallback((_) {
  fetchData();
});
  }

   @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      
      fetchData();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    fetchData();
  }

  void fetchData() async {
  String uri = "${Config.BaseApiUrl}/salleController/getAll";
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
        userdata = decodedData.map((json) => SalleModel.fromJson(json)).toList();
        isLoading = false;
      });
    }
  } catch (e) {
    print("Error: $e");
    // setState(() {
    //   isLoading = false;
    // });
  }
}

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondaryBackground,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              children: [
                searchBox(context),
                Expanded(
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 30, bottom: 10),
                              child: Text(
                                "Mes  salles",
                                //AppLocalizations(context).of('All_room'),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400
                                )
                              ),
                            ),
                            ...userdata.map((salle) => SalleItem(salleModel: salle)).toList(),
                          ],
                        ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 60,
              margin: EdgeInsets.only(bottom: 20, right: 20),
              child: ElevatedButton(
                child: Text('+', style: TextStyle(color: AppTheme.whiteColor, fontSize: 40)),
                onPressed: () { 
                  SalleModel salleModel = SalleModel(idSalle: 0, titre: '', subTitre: '', description: '', prix: 0, localName: '', nbrPlace: 0, star: 0, typeSalle: '', idPro: 0);
                  NavigationServices(context).gotoSalleForm(salleModel, 'edit');},
                style: ElevatedButton.styleFrom(
                  iconColor: AppTheme.lightSecondaryBackground,
                  foregroundColor: Colors.white,
                  elevation: 10,
                  //minimumSize: Size(60, 60),
                  backgroundColor: AppTheme.primaryColor,
                  shape: CircleBorder(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  CommonCard searchBox(BuildContext context) {
    return CommonCard(
      color: AppTheme.lightSecondaryBackground,
      radius: 36,
      child: CommonSearchBar(
        textEditingController: myController,
        iconData: FontAwesomeIcons.magnifyingGlass,
        enabled: true,
        text: "Recherche",//AppLocalizations(context).of("Where_are_you"),,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Gérer vos salles", style: TextStyle(fontSize: 18)),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(image: AssetImage(Localfiles.avatar1)),
            ),
          ),
        ],
      ),
    );
  }
}