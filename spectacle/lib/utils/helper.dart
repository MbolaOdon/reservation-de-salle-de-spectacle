// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:spectacle/models/place_data.dart';
import 'package:spectacle/models/reservation_details.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/salle_app.dart';
import 'package:spectacle/utils/enum.dart';

class Helper {
  static Widget ratinStar({double rating = 4.5}) {
   
  
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.orange, //AppThemeprimaryextColor
      ),
      itemCount: 5,
      unratedColor: Colors.black, //AppTheme.secondaryTextColor,
      itemSize: 18.0,
      direction: Axis.horizontal,
    );
  }
   
  
  static String getSalleText(SalleModelClient salleListData) {
    return "${salleListData.nbrPlace} ${"place data"}  ${salleListData.star} ${"estrade"}";
  }

  static String getListSearchedDate(DateTex dateText) {
    LanguageType _languageType = applicationcontext == null ? LanguageType.en : applicationcontext!.read<ThemeProvider>().languageType;
    return "${dateText.startDate} - ${dateText.endDate}  ${DateFormat('MMM', _languageType.toString().split(".")[1]).format(DateTime.now().add(Duration(days: 2)))}";

  }
}

class DateTex {
  late String startDate,endDate;
}