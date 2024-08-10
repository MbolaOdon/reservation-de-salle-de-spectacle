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

class MapSalleListView extends StatelessWidget {
  final VoidCallback callback;
  final SalleModelClient salleListData;
  const MapSalleListView({Key? key, required this.callback, required this.salleListData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 8, top: 8, bottom: 16),
      child: CommonCard(
        color: AppTheme.scaffoldBackgroundColor,
        radius: 16,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          child: AspectRatio(aspectRatio: 2.7,
            child: Stack(
              children: [
                Row(
                  children: [
                    AspectRatio(aspectRatio: 0.90,
                    child:  Image.network(
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
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment :CrossAxisAlignment.start,  
                          children: [
                            Text(
                              salleListData.titre,
                              textAlign: TextAlign.left,
                               style: TextStyles(context).getBoldStyle().copyWith(fontSize: 16),
                               overflow: TextOverflow.ellipsis,
                            ),
                           
                            Text(
                              salleListData.subTitre,
                              style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 14)
                            ),
                            Expanded(
                              child: SizedBox()
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(FontAwesomeIcons.mapLocationDot, size: 12, color: Theme.of(context).primaryColor,),
                                             SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "${salleListData.nbrPlace.toStringAsFixed(1)}",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 14),
                                        ),
                                        Text(
                                          AppLocalizations(context).of("place"),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 14),
                                        )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Helper.ratinStar(),
                               )
                                       
                                      ],
                                    ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          
                                        ],
                                      )
                                    )
                                    
                              ],
                              )
                          ],
                        ),
                      ),
                      ),
                    
                  ],
                ),
                Material(
                  color:Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    onTap: (){
                      callback();
                    }
                  ),
                )
              ],
            ),)
          ,
        ),
      ),
    );
  }
}