import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/modules/salle_booking/components/custom_calendar.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/salle_app.dart';
import 'package:spectacle/utils/enum.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/common_button.dart';
import 'package:spectacle/widgets/common_card.dart';
import 'package:spectacle/widgets/remove_focuse.dart';

class CalendarPopView extends StatefulWidget {
  final DateTime minimumDate;
  final DateTime maximumDate;
  final bool barrierDismissible;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) onApplyClick;
  final Function onCancelClick;
  CalendarPopView({Key? key, required this.minimumDate, required this.maximumDate, this.barrierDismissible = true, required this.initialStartDate, required this.initialEndDate, required this.onApplyClick, required this.onCancelClick}) : super(key : key);

  @override
  State<CalendarPopView> createState() => _CalendarPopViewState();

}

class _CalendarPopViewState extends State<CalendarPopView> with TickerProviderStateMixin{
  late AnimationController animationController;
  DateTime? startDate;
  DateTime? endDate;
   LanguageType _languageType = applicationcontext == null ? LanguageType.en : applicationcontext!.read<ThemeProvider>().languageType;

  @override
  void initState() {
    // TODO: implement initState
    animationController =  AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return AnimatedOpacity(
            duration: Duration(milliseconds: 100),
            opacity: animationController.value,
            child: RemoveFocuse(
              onClick: () {
                if(widget.barrierDismissible) Navigator.pop(context);
              },
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: CommonCard(
                    color: AppTheme.backgroundColor,
                    radius: 18,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            _getFromToUI(
                              AppLocalizations(context).of("From_text"),
                              startDate != null 
                              ? DateFormat("EEE, dd, MMM", 
                              _languageType.toString().split(".")[1]).format(startDate!) : "--/--",
                            ),
                            Container(
                              height: 74,
                              width: 1,
                              color: Theme.of(context).dividerColor,
                            ),
                             _getFromToUI(
                              AppLocalizations(context).of("to_text"),
                              endDate != null 
                              ? DateFormat("EEE, dd, MMM", 
                              _languageType.toString().split(".")[1]).format(endDate!) : "--/--",
                            ),
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        CustomCalendarView(
                          minimumDate: widget.minimumDate,
                          maximumDate: widget.maximumDate,
                          initialStartDate: widget.initialStartDate,
                          initialEndDate: widget.initialEndDate,
                          startEndDateChange: (DateTime startDateData, DateTime endDateData) {
                            setState(() {
                              startDate = startDateData;
                              endDate = endDateData; 
                            });
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:16, right: 16, bottom: 16, top: 8),
                          
                           
                              child: CommonButton(
                                buttonText: AppLocalizations(context).of("Apply_date"),
                                onTap: () {
                                  try{
                                    widget.onApplyClick(startDate!, endDate!);
                                    Navigator.pop(context);
                              
                                  }catch (e) {}
                                },
                              ),
                              
                              
                            
                          
                        )
                      ],
                    ),
                  ),
                  ),
              ),
            ),
          );
        }
      ),
    );
  }
  
  _getFromToUI(String title, String subtext) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 16, color: Colors.black),
           
          ),
           SizedBox(
              height: 4
            ),
             Text(
            subtext,
            textAlign: TextAlign.left,
            style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 16, 
                              color: Colors.black, fontWeight: FontWeight.bold),
           
          ),
        ],
      ),
    );
  }
}