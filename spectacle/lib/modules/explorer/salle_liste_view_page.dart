import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spectacle/config/config.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/utils/enum.dart';
import 'package:spectacle/utils/helper.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/list_cell_animation_view.dart';
import 'package:spectacle/widgets/common_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SalleListeViewPage extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final SalleModelClient salleListData;
  final AnimationController animationController;
  final Animation<double> animation;

  const SalleListeViewPage({Key? key,  this.isShowDate = false, required this.callback, required this.salleListData, required this.animationController, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: CommonCard(
          color: AppTheme.backgroundColor,
          child: ClipRect(
            child: AspectRatio(
              aspectRatio: 2.7,
              child: Stack(
                children:[
                  Row(
                    children: [
                      AspectRatio(
                      aspectRatio: 0.90,
                      child: Image.network(
                  '${Config.BaseApiUrl}public/uploads/salles/${salleListData.design}',
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error);
                  },
                )
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width >= 360 ? 12 :8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              salleListData.titre,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: TextStyles(context).getBoldStyle().copyWith(
                                          fontSize: 16,
                                        ),
                                overflow: TextOverflow.ellipsis,//TextStyles(context).getBoldStyle(),

                            ),
                            Text(
                              salleListData.subTitre,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: TextStyles(context)
                                    .getDescriptionStyle()
                                    .copyWith(
                                      fontSize: 14,
                                    ),//TextStyles(context).getBoldStyle(),

                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // ignore: deprecated_member_use
                                            Icon(FontAwesomeIcons.mapLocationDot, size: 12, color: Theme.of(context).primaryColor),
                                            SizedBox(width: 15.0),
                                            Text(
                                                "${salleListData.nbrPlace.toStringAsFixed(1)}",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyles(context)
                                                    .getDescriptionStyle()
                                                    .copyWith(
                                                      fontSize: 14,
                                                    ),
                                            ),
                                            SizedBox(
                                              width:10.0
                                            ),
                                            Expanded(
                                              child: Text(
                                               AppLocalizations(context).of("place"),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyles(context)
                                                      .getDescriptionStyle()
                                                      .copyWith(
                                                        fontSize: 14,
                                                      ), ),
                                            ),
                                             SizedBox(
                                              width:10.0
                                            )
                                          ],
                                          ),
                                          Helper.ratinStar(),
                                      ],
                                    ),
                                    ),
                                    FittedBox(
                                      child: Padding(
                                        padding: EdgeInsets.only(right:8),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                             Text(
                                                "${salleListData.prix.toStringAsFixed(1)}",
                                                textAlign: TextAlign.left,
                                               
                                                style: TextStyles(context)
                                                  .getBoldStyle()
                                                  .copyWith(fontSize: 22)),

                                            
                                            Padding(
                                              padding: EdgeInsets.only(top: context.read<ThemeProvider>().languageType == LanguageType.ar ? 2.0 :0.0),
                                                
                                              child: Text(
                                                //AppLocalization(context).of("par jour"),
                                                "Par jour",
                                                style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 14),

                                              ),
                                            ),
                                           
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                                ),
                            )
                          ],
                        ),
                        ),
                    )
                    ]
                    
                  ),

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      onTap: () {
                        try{
                          callback();
                        }catch (e) {}
                      },
                    ),
                  )
                ]
              ),),
          ),
        ),
        ),
      );
  }
}