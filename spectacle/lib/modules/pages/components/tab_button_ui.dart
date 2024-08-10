import 'package:flutter/material.dart';
import 'package:spectacle/utils/themes.dart';

class TabButtonUI extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  final bool isSelected;
  final String text;
  
  const TabButtonUI({Key? key, required this.icon, this.onTap, required this.isSelected, required this.text}) : super(key: key);

  @override   
  Widget build(BuildContext context) {
    final _color = isSelected ? AppTheme.primaryColor : Color.fromARGB(221, 85, 85, 85);
    return Expanded(
      child: Material(
        color: const Color.fromARGB(0, 134, 39, 39),
        child: InkWell(
          highlightColor: Color.fromARGB(0, 189, 53, 53),
          splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
          onTap: onTap,
          child: Column(
            children: [
              SizedBox(
               height: 4,
              ),
              Container(
                  width: 30,
                  height:32,
                  child: Icon(
                    icon,
                    size: 18.0,
                    color: _color,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      text,
                      style: TextStyle().copyWith(color: _color),
                    ),
                  ),
                )
            ],
          ),
        ),
        
      ),
    );
  }
}