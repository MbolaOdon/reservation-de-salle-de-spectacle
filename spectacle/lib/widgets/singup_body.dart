import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/rouded_button.dart';
import 'package:spectacle/utils/social_icon.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/already_have_an_account_check.dart';
import 'package:spectacle/widgets/common_button.dart';
import 'package:spectacle/widgets/or_divider.dart';
import 'package:spectacle/widgets/rounded_input_field.dart';
import 'package:spectacle/widgets/rounded_password_field.dart';
import 'package:spectacle/widgets/sinup_background.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key : key);

  @override
  State<Body> createState() => _BodyState();

}

class _BodyState extends State<Body> {
  bool clientRadio = false;
  bool proprietaireRadio = false;
  bool messageChoose = false;
  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }
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
                    Center(
                      child: accountType(),
                    ),
                    

                    SizedBox(
                      height: size.height * 0.03,
                    ),
              
                     CommonButton(
                        padding: EdgeInsets.only(left: 24, right: 24, bottom: size.height * 0.01),
                        buttonText: AppLocalizations(context).of("create_account"),
                        onTap: () {
                          if(clientRadio || proprietaireRadio) {
                      setState(() {
                        messageChoose = false;
                      });
                      
                      NavigationServices(context).gotoSignupForm();
                      }
                    else { setState(() {
                        messageChoose = true;
                      });
                      };
                        },
                      ),
                SizedBox(
                    height: size.height * 0.01,
                  ),
              Padding(
                
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
                          
                child: AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () { 
                    NavigationServices(context).gotoLoginPageScreen();
                    }
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
  
  Widget accountType() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
               IconButton(
                icon: Icon(proprietaireRadio ? Icons.radio_button_on : Icons.radio_button_off, color: AppTheme.primaryColor,),
                
                onPressed: () {
                  setState(() {
                    clientRadio = false;
                    proprietaireRadio = !proprietaireRadio;
                    messageChoose = false;
                  });
                },
                ),
              Text(AppLocalizations(context).of('I_want_rental_salle')
              
              ),
            ],
          ),
           Row(
            children: [
              IconButton(
                icon: Icon(clientRadio ? Icons.radio_button_on : Icons.radio_button_off, color: AppTheme.primaryColor,),
                
                onPressed: () {
                  setState(() {
                    clientRadio = !clientRadio;
                    proprietaireRadio = false;
                    messageChoose = false;
                  });
                },
                ),
              Text(AppLocalizations(context).of('I_want_to_reserve_salle')
              
              ),
            ],
          ),
           Text(messageChoose ? AppLocalizations(context).of('choose_account') : "",
          style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.w400),
          ) 
        ],
      ),
      
      );
  }
}

