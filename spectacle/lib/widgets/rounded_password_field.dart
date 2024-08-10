import 'package:flutter/material.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/text_field_continer.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  const RoundedPasswordField({
    super.key, required this.onChanged, required this.hintText
  });


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
  bool hidePassword = true;
    return TextFieldContainer(
     child: TextField(
      keyboardType: TextInputType.visiblePassword,
      onChanged: onChanged,
       obscureText: hidePassword,
       decoration: InputDecoration(
         hintText: hintText,
         
         icon: Icon(
           Icons.lock,
           color: AppTheme.primaryColor,
         ),
         suffixIcon: IconButton(
          onPressed: (){
          
              hidePassword = !hidePassword;
           
          },
          icon: Icon(hidePassword? Icons.visibility_off : Icons.visibility,
           color: AppTheme.primaryColor,)
           
         ),
         border: InputBorder.none,
         ),
     ),);
  }
}