import 'package:flutter/material.dart';
import 'package:spectacle/api/auth_service.dart';
import 'package:spectacle/config/config.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/login_model.dart';
import 'package:spectacle/providers/secure_storage.dart';
import 'package:spectacle/routes/route_generator.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/rouded_button.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/already_have_an_account_check.dart';
import 'package:spectacle/widgets/common_button.dart';
import 'package:spectacle/widgets/rounded_input_field.dart';
import 'package:spectacle/widgets/rounded_password_field.dart';
import 'package:spectacle/widgets/text_field_continer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late String _email;
  late String _password;
 
   LoginRequestModel requestModel = LoginRequestModel(email: '', password: '');

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

 

  Future<void> _handleLogin() async {
   setState(() {
      requestModel.email = _email;
      requestModel.password = _password;
    });
  print(requestModel.password);
    AuthService authService = AuthService();
    try {
      Object result = await authService.login(requestModel);
      if (result == true) {
        NavigationServices(context).gotoHomePage();
      } else {
        // Handle login failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    } catch (e) {
      print('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldkey,
      // backgroundColor: Colors.white, 
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Center(
            // Utilisation de Center pour centrer le TextButton
            child: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "CONNEXION",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppTheme.primaryTextColor),
                    ),
                    Image.asset(
                      "assets/images/login-pana.png",
                      width: size.width * 0.6,
                    ),
                    RoundedInputField(
                      icon: Icons.email,
                      hintText: "Email",
                      onChanged: (value) {
                        _email = value;
                        print(value);
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    RoundedPasswordField(
                      hintText: AppLocalizations(context).of('password'),
                      onChanged: (value) {
                        _password = value;
                        print(value);
                      },
                    ),
                   
                   
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    CommonButton(
                      padding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
                      buttonText: AppLocalizations(context).of("login"),
                      onTap: () {
                        _handleLogin();
                        //NavigationServices(context).gotoHomePage();
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
                      child: AlreadyHaveAnAccountCheck(
                        press: () {
                          NavigationServices(context).gotoSinupPage();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
    ;
  }
}
