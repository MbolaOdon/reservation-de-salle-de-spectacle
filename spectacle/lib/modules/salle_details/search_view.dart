import 'package:flutter/material.dart';
//import 'package:flutter_localization/flutter_localization.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/utils/helper.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/common_card.dart';
import 'package:spectacle/widgets/list_cell_animation_view.dart';

class SearchView extends StatelessWidget {
  final SalleModelClient salleInfo;
  final AnimationController animationController;
  final Animation<double> animation;

  const SearchView({Key? key, required this.salleInfo, required this.animationController, required this.animation}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListCellAnimationView(
      animationController: animationController,
      animation: animation,
      child: 
        Padding(
          padding: EdgeInsets.all(16.0),
          child: AspectRatio(aspectRatio: 0.75,
            child: CommonCard(
              color:  AppTheme.backgroundColor,
              radius: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5, 
                      child: Image.asset(salleInfo.design, fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.all(0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              salleInfo.titre,
                              style: TextStyles(context).getBoldStyle(),
                            ),
                            Text(
                              Helper.getSalleText(salleInfo),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                                color: Theme.of(context).disabledColor.withOpacity(0.6),
                              ),
                            ),
                             Text(
                              Helper.getSalleText(salleInfo),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                                color: Theme.of(context).disabledColor.withOpacity(0.6),
                              ),
                            )
                          ],
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

     
    );
  }
}