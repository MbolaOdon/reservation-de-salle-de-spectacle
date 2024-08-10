import 'package:flutter/material.dart';
import 'package:spectacle/utils/themes.dart';

class CommonSearchBar extends StatelessWidget {
  final String? text;
  final bool enabled, isShow;
  final double height;
  final IconData? iconData;
  final TextEditingController? textEditingController;

  const CommonSearchBar({Key? key, required this.text,  this.enabled = false, this.isShow = true,  this.height = 48 , this.iconData, this.textEditingController}) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
     child: Container(
      height: height,
      child: Center(
        child: Row(
          children: [
            isShow == true ? Icon(iconData,size: 18, color: AppTheme.primaryColor)
            : SizedBox(),
            isShow == true ? SizedBox(width: 8) : SizedBox(),
            Expanded(
              child: TextField(
                controller: textEditingController,
                maxLines: 1,
                enabled: enabled,
                onChanged: (String text) {},
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  errorText: null,
                  border: InputBorder.none,
                  hintText: text,
                  hintStyle: TextStyle(
                    color:  Color.fromARGB(255, 0, 0, 0) ,//secondaryColors
                    fontSize: 16,
                  )
                ),
              )
              )
          ]
        ),
      ),
     ),
    );
  }
}