import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spectacle/api/reservation_service.dart';
import 'package:spectacle/config/config.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/modules/salle_booking/components/calendar_pop_view.dart';
import 'package:spectacle/modules/salle_details/date_picker_range.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/salle_app.dart';
import 'package:spectacle/utils/enum.dart';
import 'package:provider/provider.dart';
import 'package:spectacle/utils/helper.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/common_button.dart';
//import 'package:date_range_picker/date_range_picker.dart' as date_range_picker;

class SalleBookingView extends StatefulWidget {
  final SalleModelClient salleData;
  final AnimationController animationController;
  final Animation<double> animation;

  SalleBookingView(
      {Key? key,
      required this.salleData,
      required this.animationController,
      required this.animation})
      : super(key: key);

  @override
  State<SalleBookingView> createState() => _SalleBookingViewState();
}

class _SalleBookingViewState extends State<SalleBookingView> {
  var pageController = PageController(initialPage: 0);
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 365));
  // LanguageType _languageType = applicationcontext == null
  //     ? LanguageType.en
  //     : applicationcontext!.read().languageType;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 365));
  late ReservationService reservService;
  bool disableReserv = true;

  // _SalleBookingViewState() {
  //   reservService = ReservationService();
  // }
  @override
  void initState() {
    super.initState();
    reservService = ReservationService();
  }

  Future<void> handleReservation() async {
    print(_startDate);
    print(_endDate);

    if (await reservService.addReservation(
        widget.salleData.idSalle, _startDate, _endDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Reservation tenu en compte\n Veillez patientez pendant\n la validation')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = widget.salleData.design.split('/');
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 40 * (1.0 - widget.animation.value), 0.0),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: PageView(
                        controller: pageController,
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          for (var image in images)
                            Image.network(
                              '${Config.BaseApiUrl}public/uploads/salles/${widget.salleData.design}',
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmoothPageIndicator(
                        controller: pageController, // PageController
                        count: 3,
                        effect: WormEffect(
                            activeDotColor: Theme.of(context).primaryColor,
                            dotColor: Theme.of(context).scaffoldBackgroundColor,
                            dotHeight: 10.0,
                            dotWidth: 10.0,
                            spacing: 5.0), // your preferred effect
                        onDotClicked: (index) {},
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.salleData.titre,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyles(context)
                                .getBoldStyle()
                                .copyWith(fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${widget.salleData.nbrPlace}",
                            textAlign: TextAlign.left,
                            style: TextStyles(context)
                                .getBoldStyle()
                                .copyWith(fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Text(
                              " place",
                              //AppLocalizations(context).of("per_night"),
                              style: TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_startDate != null && _endDate != null)
                            Text(
                                'Reservée de: ${DateFormat('d MMMM yyyy').format(_startDate!)} à ${DateFormat('d MMMM yyyy').format(_endDate!)}',
                                style: TextStyle(fontSize: 14)),
                            SizedBox(height: 10,),
                          ElevatedButton(
                            onPressed: _showDateRangePicker,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:AppTheme.primaryColor
                            ),
                            child: Text('Quand vous souhaitez reserver'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Plus details",
                                    // AppLocalizations(context)
                                    //     .of("more_details"),
                                    style: TextStyles(context).getBoldStyle(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      // color: Theme.of(context).backgroundColor,
                                      size: 24,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDateRangePicker() async {
    final pickedDateRange = await showModalBottomSheet<DateTimeRange>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      builder: (context) => AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Appuiée sur les dates',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              DateRangePicker(
                initialStartDate: _startDate,
                initialEndDate: _endDate,
                primaryColor: AppTheme.primaryColor,
                accentColor: AppTheme.primaryColor,
                onDateRangeChanged: (DateTimeRange dateRange) {
                  setState(() {
                    _startDate = dateRange.start;
                    _endDate = dateRange.end;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(DateTimeRange(
                      start: _startDate!,
                      end: _endDate!,
                    ));
                    handleReservation();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppTheme.primaryColor,
                    maximumSize: Size.fromWidth(150),
                    elevation:2
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Envoyer'),
                      Icon(Icons.send),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );

    if (pickedDateRange != null) {
      setState(() {
        _startDate = pickedDateRange.start;
        _endDate = pickedDateRange.end;
      });
    }
  }
}
