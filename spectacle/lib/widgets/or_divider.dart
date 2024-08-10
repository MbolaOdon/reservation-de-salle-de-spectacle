import 'package:flutter/material.dart';
import 'package:spectacle/utils/themes.dart';


class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
   
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buidDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("or",
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            
            ),),
          ),
          buidDivider(),
          ],
      ),
    );
    
  }

  Expanded buidDivider() {
    return Expanded(child: Divider(
          color:AppTheme.primaryColor,
          height: 1.5,
        )
        );
  }
}

