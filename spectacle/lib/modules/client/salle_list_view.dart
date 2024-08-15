import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectacle/config/config.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/utils/helper.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/common_card.dart';
import 'package:spectacle/widgets/list_cell_animation_view.dart';

class SalleListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final SalleModelClient salleListData;
  final AnimationController animationController;
  final Animation<double> animation;

  const SalleListView({Key? key,  this.isShowDate = false , required this.callback, required this.salleListData, required this.animationController, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData favouriteIcon = Icons.favorite_border;
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: Column(
          children: [
            isShowDate ? 
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Helper.getSalleText(salleListData!) + ',',
                  style: TextStyles(context).getRegularStyle().copyWith(fontSize: 14),) ,//getSalleText(salleListData!.date))
                  Padding(
                    padding: EdgeInsets.only(top: 2.0,),
                    child:  Text(Helper.getSalleText(salleListData!),
                          style: TextStyles(context).getRegularStyle().copyWith(fontSize: 14),) ,//getSalleText(salleListData!.date))
                  
                    )
                ],
              ),
              ) 
            : SizedBox(),
            CommonCard(
              color: AppTheme.backgroundColor,
              radius: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        AspectRatio(aspectRatio: 2,
                        child: Image.network(
                              '${Config.BaseApiUrl}public/uploads/salles/${salleListData.design}',
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error);
                              },
                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      salleListData.titre,
                                      textAlign: TextAlign.left,
                                      style: TextStyles(context).getBoldStyle().copyWith(fontSize: 22),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                      salleListData.subTitre,
                                      style: TextStyles(context).getDescriptionStyle(),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(FontAwesomeIcons.mapLocationDot, size:12,
                                          color: Theme.of(context).primaryColor,),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "${salleListData.nbrPlace.toStringAsFixed(1)}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles(context).getDescriptionStyle(),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations(context).of("place"),
                                        overflow: TextOverflow.ellipsis,
                                         style: TextStyles(context).getDescriptionStyle(),
                                      ),
                                    )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: [
                                          Helper.ratinStar(),
                                          Text('${salleListData.localName}',
                                          style: TextStyles(context).getDescriptionStyle(),),
                                          Text(
                                             AppLocalizations(context).of("reviews"),
                                              style: TextStyles(context).getDescriptionStyle(),
                                          )
                                        ],
                                      )
                                    )
                                  ]
                                ),
                              ),
                            ))
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          onTap: (){
                            try{
                              callback();
                            }catch(e){}
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).dialogBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        
                        child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          onTap: (){
                            setState(){
                              favouriteIcon = Icons.favorite;
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              favouriteIcon,
                               color: Theme.of(context).primaryColor,
                            )
                          ),
                        ),
                      ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}