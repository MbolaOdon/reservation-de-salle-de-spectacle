import 'package:flutter/material.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/text_field_continer.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    super.key, required this.icon , required this.onChanged, required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
         child: TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: onChanged,
           decoration: InputDecoration(
             icon: Icon(
               icon,
               color: AppTheme.primaryColor),
             hintText: hintText,
             border: InputBorder.none,
    
           ),
         ),
       );
  }
}