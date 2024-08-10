import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/reservation_details.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:provider/provider.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/modules/salle_booking/components/calendar_pop_view.dart';
import 'package:spectacle/modules/salle_booking/components/salle_pop_up_view.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/salle_app.dart';
import 'package:spectacle/utils/enum.dart';
import 'package:provider/provider.dart';
import 'package:spectacle/utils/helper.dart';
import 'package:spectacle/utils/text_styles.dart';

class TimeDateView extends StatefulWidget {
  TimeDateView({Key? key}) : super(key: key);

  @override
  State<TimeDateView> createState() => _TimeDateViewState();
}

class _TimeDateViewState extends State<TimeDateView> {
  final SalleModelClient _salleListData = SalleModelClient(idSalle: 0,idPro: 0,idPho: 0, titre: '', subTitre: '', description: '', prix: 0, localName: '', nbrPlace: 0, star: 0, typeSalle: '', design: '', );
  ReservationDetails _reservationDetails = ReservationDetails();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 5));
  LanguageType _languageType = applicationcontext == null ? LanguageType.en : applicationcontext!.read<ThemeProvider>().languageType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _getDateSalleUI(AppLocalizations(context).of("choose_date"), 
          "${DateFormat("dd, MMM", _languageType.toString().split(".")[1]).format(startDate)} - ${DateFormat("dd, MMM", _languageType.toString().split(".")[1]).format(endDate)}", () {
             _showDemoDialog(context);
          }
          ),
          Container(
            width: 1,
            height: 42,
            color: Colors.grey.withOpacity(0.8),
           
          ),
          _getDateSalleUI(AppLocalizations(context).of("choose_date"), 
          Helper.getSalleText(_salleListData), () {
              _showPopUp();
          }
         ),
        ],
      ),
    );
  }
  
  Widget _getDateSalleUI(String title, String subtitle, VoidCallback onTap) {
    return Expanded(
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top:4, bottom: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 16)
                    ),
                    SizedBox(height: 8),
                     Text(
                      subtitle,
                      style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 16, color: Colors.black)
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  void _showDemoDialog(BuildContext context) {
    showDialog(
    context: context,
     builder: (BuildContext context) => CalendarPopView(
      barrierDismissible: true,
      minimumDate: DateTime.now(),
      maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 100),
      initialStartDate: startDate,
      initialEndDate: endDate,
      onApplyClick: (DateTime startDate, DateTime endDate){
        setState(() {
          startDate = startDate;
          endDate = endDate;
        });
      },
      onCancelClick: () {},
     )
    );
  }
  
  void _showPopUp() {
    showDialog(context: context,
    builder: (BuildContext context) => SallePopUpView(
      onChange: (data) {
        setState(() {
          _reservationDetails = data as ReservationDetails;
        });
      },
      barrierDismissible: true,
      reservationDetails: _reservationDetails,
    ) 
    );
  }
}