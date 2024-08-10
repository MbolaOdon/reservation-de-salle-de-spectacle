import 'package:flutter/material.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/modules/pages/change_password.dart';
import 'package:spectacle/modules/pages/home_page.dart';
import 'package:spectacle/modules/pages/login_page.dart';
import 'package:spectacle/modules/pages/signup_form.dart';
import 'package:spectacle/modules/pages/sinup_page.dart';
import 'package:spectacle/modules/profile/country_screen.dart';
import 'package:spectacle/modules/profile/currency_screen.dart';
import 'package:spectacle/modules/profile/edit_profile.dart';
import 'package:spectacle/modules/profile/hepl_center_screen.dart';
import 'package:spectacle/modules/profile/how_do_screen.dart';
import 'package:spectacle/modules/profile/invite_screen.dart';
import 'package:spectacle/modules/profile/settings_screen.dart';
import 'package:spectacle/modules/proprietaire/form_salle_screen.dart';
import 'package:spectacle/modules/proprietaire/upload_image_salle.dart';
import 'package:spectacle/modules/salle_booking/filter_screen/filters_screen.dart';
import 'package:spectacle/modules/salle_booking/salle_home_screen.dart';
import 'package:spectacle/modules/salle_details/Salle_details.dart';
import 'package:spectacle/modules/salle_details/reviews_list_screen.dart';
import 'package:spectacle/modules/salle_details/salle_booking_screen.dart';
import 'package:spectacle/modules/salle_details/search_screen.dart';
import 'package:spectacle/routes/routes.dart';

class NavigationServices {
  NavigationServices(this.context);

  final BuildContext context;

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog = false}) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget, fullscreenDialog: fullscreenDialog),
    );
  }

  void gotoSplashScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.Splash, (Route<dynamic> route) => false);
  }
  // void gotoLoginPageScreen() {
  //   Navigator.pushNamedAndRemoveUntil(
  //       context, RoutesName.Login, (Route<dynamic> route) => false);
  // }

  // void gotoSinupPage() {
  //    Navigator.pushNamedAndRemoveUntil(
  //       context, RoutesName.SingUp, (Route<dynamic> route) => false);
  // }

  // void gotoHomePage() {
  //    Navigator.pushNamedAndRemoveUntil(
  //       context, RoutesName.Home, (Route<dynamic> route) => false);
  // }

  //  void gotoSearchScreen() {
  //    Navigator.pushNamedAndRemoveUntil(
  //       context, RoutesName.SearchScreen, (Route<dynamic> route) => false);
  // }

  //  void gotoSalleHomeScreen() {
  //    Navigator.pushNamedAndRemoveUntil(
  //       context, RoutesName.SalleHomeScreen, (Route<dynamic> route) => false);
  // }
  // void gotoFilterScreen() {
  //    Navigator.pushNamedAndRemoveUntil(
  //       context, RoutesName.FilterScreen, (Route<dynamic> route) => false);
  // }
  Future<dynamic> gotoSinupPage() async {
    return await _pushMaterialPageRoute(SinupPage());
  }

  Future<dynamic> gotoSignupForm() async {
    return await _pushMaterialPageRoute(SignupForm());
  }

  Future<dynamic> gotoLoginPageScreen() async {
    return await _pushMaterialPageRoute(LoginPage());
  }

  Future<dynamic> gotoHomePage() async {
    return await _pushMaterialPageRoute(HomePage());
  }
  Future<dynamic> gotoSearchScreen() async {
    return await _pushMaterialPageRoute(SearchScreen());
  }

  Future<dynamic> gotoFilterScreen() async {
    return await _pushMaterialPageRoute(FiltersScreen());
  }

  Future<dynamic> gotoSalleHomeScreen() async {
    return await _pushMaterialPageRoute(SalleHomeScreen());
  }

  Future<dynamic> gotoSalleBookingScreen(String salleName) async {
    return await _pushMaterialPageRoute(SalleBookingScreen(SalleName: salleName,));
  }

  Future<dynamic> gotoSalleDetails(SalleModelClient salleData) async {
    return await _pushMaterialPageRoute(SalleDetails( salleData : salleData));
  }

  Future<dynamic> gotoReviewsListScreen() async {
    return await _pushMaterialPageRoute(ReviewsListScreen());
  }

  Future<dynamic> gotoEditProfile() async {
    return await _pushMaterialPageRoute(EditProfile());
  }

  Future<dynamic> gotoSettingsScreen() async {
    return await _pushMaterialPageRoute(SettingsScreen());
  }

  Future<dynamic> gotoHeplCenterScreen() async {
    return await _pushMaterialPageRoute(HeplCenterScreen());
  }

  Future<dynamic> gotoChangepasswordScreen() async {
    return await _pushMaterialPageRoute(ChangepasswordScreen());
  }

  Future<dynamic> gotoInviteFriend() async {
    return await _pushMaterialPageRoute(InviteFriend());
  }

  Future<dynamic> gotoCurrencyScreen() async {
    return await _pushMaterialPageRoute(CurrencyScreen(),
        fullscreenDialog: true);
  }

  Future<dynamic> gotoCountryScreen() async {
    return await _pushMaterialPageRoute(CountryScreen(),
        fullscreenDialog: true);
  }

  Future<dynamic> gotoHowDoScreen() async {
    return await _pushMaterialPageRoute(HowDoScreen());
  }

  Future<dynamic> gotoSalleForm(SalleModel salleModel, String s) async {
    return await _pushMaterialPageRoute(SalleForm(salle: salleModel,));
  }

  Future<dynamic> gotoSalleImage() async {
    return await _pushMaterialPageRoute(ImageUploadScreen());
  }
}


  

