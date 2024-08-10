import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/rouded_button.dart';
import 'package:spectacle/utils/social_icon.dart';
import 'package:spectacle/widgets/already_have_an_account_check.dart';
import 'package:spectacle/widgets/common_button.dart';
import 'package:spectacle/widgets/or_divider.dart';
import 'package:spectacle/widgets/rounded_input_field.dart';
import 'package:spectacle/widgets/rounded_password_field.dart';

class SignupForm extends StatefulWidget {
  SignupForm({Key? key}) : super(key : key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(AppLocalizations(context).of('sign_up'),
              style: TextStyle(fontWeight: FontWeight.bold),
              ),
               
                  SizedBox(
                      height: size.height * 0.03,
                    ),
                    RoundedInputField(
                      icon: Icons.person,
                hintText: AppLocalizations(context).of('full_name'),
                onChanged: (value) {},
              ),
              SizedBox(
                      height: size.height * 0.01,
                    ),
                     RoundedInputField(
                      icon: Icons.phone,
                hintText: AppLocalizations(context).of('phone'),
                onChanged: (value) {},
              ),
              SizedBox(
                      height: size.height * 0.01,
                    ),
                    RoundedInputField(
                      icon: Icons.location_city,
                hintText: AppLocalizations(context).of('adresse'),
                onChanged: (value) {},
              ),
              SizedBox(
                      height: size.height * 0.01,
                    ),
              RoundedInputField(
                icon: Icons.email,
                hintText: AppLocalizations(context).of('email'),
                onChanged: (value) {},
              ),
              SizedBox(
                      height: size.height * 0.01,
                    ),
              RoundedPasswordField(
                onChanged: (value) {},
                hintText: AppLocalizations(context).of('password'),
                ),
                SizedBox(
                      height: size.height * 0.01,
                    ),
                 RoundedPasswordField(
                        hintText: AppLocalizations(context).of('password'),
                        onChanged: (value) {
                          //_password = value;
                          print(value);
                        },
                      ),
                      SizedBox(
                      height: size.height * 0.01,
                    ),
                     CommonButton(
                        padding: EdgeInsets.only(left: 24, right: 24, bottom: size.height * 0.01),
                        buttonText: AppLocalizations(context).of("sign_up"),
                        onTap: () {
                          _handlesingUp();
                          //NavigationServices(context).gotoHomePage();
                        },
                      ),
                SizedBox(
                    height: size.height * 0.01,
                  ),
              Padding(
                
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
                          
                child: AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () { NavigationServices(context).gotoLoginPageScreen();}
                ),
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                
                SocialIcon(
                  icon: Icons.facebook_outlined,
                  color: const Color.fromARGB(255, 33, 96, 243),
                  press: () {},
                ),
                SocialIcon(
                  icon: FontAwesomeIcons.twitter,
                  color: Color.fromARGB(255, 35, 146, 243),
                  press: () {},
                ),
                SocialIcon(
                  icon: FontAwesomeIcons.googlePlusG,
                   color: Color.fromARGB(255, 243, 33, 33),
                  press: () {},
                )
              ],)
          ],),
        ),
      ),
    );
  }
  
  void _handlesingUp() {}
  
  }
