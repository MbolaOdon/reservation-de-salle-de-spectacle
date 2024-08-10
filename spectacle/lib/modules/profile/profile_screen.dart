import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/localfiles.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/bottom_top_move_animation_view.dart';
import 'package:provider/provider.dart';
import 'package:spectacle/widgets/profile_menu.dart';
import '../../models/setting_list_data.dart';

class ProfileScreen extends StatefulWidget {
  final AnimationController animationController;

  const ProfileScreen({Key? key, required this.animationController})
      : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<SettingsListData> userSettingsList = SettingsListData.userSettingsList;

  @override
  void initState() {
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.angleLeft)),
        title: Text(AppLocalizations(context).of('profile'), style: Theme.of(context).textTheme.headlineMedium,),
        actions: [IconButton(onPressed: () {}, icon:  Icon(AppTheme.isLightMode ? FontAwesomeIcons.moon : FontAwesomeIcons.sun),)],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(image: AssetImage(Localfiles.avatar1)),
                    )
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppTheme.primaryColor
                      ),
                      child: Icon( Icons.camera_alt, size: 20, color: AppTheme.primaryTextColor),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text('Mbola Odon', style: Theme.of(context).textTheme.headlineMedium,),
              Text('superadmin@gmail.com', style: Theme.of(context).textTheme.bodyLarge,),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () { NavigationServices(context).gotoEditProfile(); },
                  child: Text(AppLocalizations(context).of('edit_profile'), style: TextStyle(color: AppTheme.whiteColor,)),
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, side: BorderSide.none, shape: StadiumBorder()),
                  
                  ),
                
              ),
              SizedBox(height: 30),
              Divider(),
              SizedBox(height: 10,),

              ProfileMenuWidget(
                title: AppLocalizations(context).of('setting'),
                icon: FontAwesomeIcons.gear,
                onPress: () { NavigationServices(context).gotoSettingsScreen();},),
              ProfileMenuWidget(
                title: AppLocalizations(context).of('billing_details'),
                icon: FontAwesomeIcons.wallet,
                onPress: () {},),
              ProfileMenuWidget(
                title: AppLocalizations(context).of('user_management'),
                icon: FontAwesomeIcons.userCheck,
                onPress: () {},),
              Divider(color: Colors.grey),
              SizedBox(height: 10,),
              ProfileMenuWidget(
                title: AppLocalizations(context).of('information'),
                icon: FontAwesomeIcons.info,
                onPress: () {},),
              ProfileMenuWidget(
                title: AppLocalizations(context).of('logout'),
                icon: FontAwesomeIcons.rightFromBracket,
                onPress: () {NavigationServices(context).gotoLoginPageScreen();},),
            ],
            ),
        ),
      ),
    );
  }

}

