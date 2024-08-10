import 'package:flutter/material.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';

class FilterBarUI extends StatelessWidget {
  final int foundSalle;
  const FilterBarUI({Key? key, required this.foundSalle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.scaffoldBackgroundColor,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right:16,top: 8, bottom: 4),
            child: Row(
              children: [
                Padding(padding: EdgeInsets.all(8.0),
                child: Text(
                  "${foundSalle}",
                  style: TextStyles(context).getRegularStyle(),
                ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Text(
                      AppLocalizations(context).of("room_found"),
                      style: TextStyles(context).getRegularStyle(),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      NavigationServices(context).gotoFilterScreen();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          Text(AppLocalizations(context).of("filter"),
                            style: TextStyles(context).getRegularStyle(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.sort,
                              color: Theme.of(context).primaryColor,
                            ),
                            
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            ),
            Positioned(
              top:0,
              left:0,
              right:0,
              child: Divider(
                height:1,
              ),
            )
        ],
      ),
    );
  }
}