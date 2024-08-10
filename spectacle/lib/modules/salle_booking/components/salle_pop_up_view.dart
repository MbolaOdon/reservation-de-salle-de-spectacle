import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/place_data.dart';
import 'package:spectacle/models/reservation_details.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/utils/enum.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/common_button.dart';
import 'package:spectacle/widgets/common_card.dart';

class SallePopUpView extends StatefulWidget {
  final Function(PlaceData) onChange;
  final bool barrierDismissible;
  final ReservationDetails reservationDetails;
  SallePopUpView({Key? key, required this.onChange, required this.barrierDismissible, required this.reservationDetails}) : super(key : key);

  @override
  State<SallePopUpView> createState() => _SallePopUpViewState();
}

class _SallePopUpViewState extends State<SallePopUpView> with TickerProviderStateMixin{
  PopupTextType popupTextType = PopupTextType.no;
  late AnimationController animationController;

  DateTime? startDate;
  DateTime? endDate;
  ReservationDetails? _reservationDetails;

  @override
  void initState() {
    animationController =  AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    animationController.forward();
    _reservationDetails = ReservationDetails(security: widget.reservationDetails.security, organisateur: widget.reservationDetails.organisateur);
    
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeProvider>(context);
    return Center(
      child: Scaffold(
        backgroundColor: appTheme.isLightMode ? Colors.transparent : Theme.of(context).dialogBackgroundColor.withOpacity(0.4) ,
        body: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return AnimatedOpacity(
              opacity: animationController.value,
              duration: Duration(milliseconds: 100),
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.all(24.0),
                  child: CommonCard(
                    color: AppTheme.backgroundColor,
                    radius: 24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations(context).of("room_selected"),
                            style: TextStyles(context).getBoldStyle().copyWith(fontSize: 16),
                          ),
                        ),
                        Divider(
                          height:1
                        ),
                        getSalleView(AppLocalizations(context).of("Security"),  PopupTextType.no),
                        getSalleView(AppLocalizations(context).of("organisateur"),  PopupTextType.ad),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
                          child: CommonButton(
                            buttonText: AppLocalizations(context).of("Apply_date"),
                            onTap: (){
                              try{
                               // widget.onChange(_reservationDetails! as PlaceData,);
                                Navigator.pop(context);
                              }catch(e) {}
                            }
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              );
          },
        ),
      ),
    );
  }

  Widget getSalleView(String txt, PopupTextType popupTextType) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Divider(
                            height: 1,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(txt,
                                      textAlign: TextAlign.left,
                                      style: TextStyles(context).getBoldStyle().copyWith(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            ),

                            Material(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                // Checkbox(value: true, onChanged: (){}),
                                // Checkbox(value: true, onChanged: (){})
                                // Checkbox(value: true, onChanged: (){},)
                                ],
                              ),
                            ),
                            
                         
                        ],
                      )
                    )
                  ],
                ),
                )
            ],
          )
        ],
      ),
    );
  }
}