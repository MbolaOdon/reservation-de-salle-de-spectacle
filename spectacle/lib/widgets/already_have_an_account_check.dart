import 'package:flutter/material.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/utils/themes.dart';


class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  
  const AlreadyHaveAnAccountCheck({
    super.key,  this.login = true, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
     children: <Widget>[
       
       GestureDetector(
         onTap: press,
         child: Text(AppLocalizations(context).of(login? "already_not_have_account": "already_have_account"),
         style: TextStyle(
           color: AppTheme.primaryColor, fontWeight: FontWeight.bold,
         ),
         ),
       )
     ],
     );
  }
}