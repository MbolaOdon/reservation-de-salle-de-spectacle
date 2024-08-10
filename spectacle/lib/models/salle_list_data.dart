import 'package:flutter/material.dart';
import 'package:spectacle/utils/localfiles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SalleListData {
  late String imagePath, titleText, subText;
 
  late String dateText,roomSizeText;
 
  late double dist, rating;
  late int reviews;
  late bool isSelected;
 
  LatLng? location;
  Offset? screenMapPin;

  SalleListData({
    this.imagePath = '',
    this.titleText = '',
    this.subText = '',
   
    this.dateText = '',
    this.roomSizeText = '',
    this.dist = 2.0,
    this.rating = 4.4,
    this.reviews = 0,
    this.isSelected = false,
    this.location,
    this.screenMapPin

    


  });
  static List<SalleListData> lastsSearchesList = [
     SalleListData(
      imagePath: Localfiles.salle_1,
      titleText: 'Coliseum',
      subText: 'wembley, Londre',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      isSelected: true,
      roomSizeText: '2100 personne',
      location: LatLng(51.516898, -0.143377),
      ),
      SalleListData(
      imagePath: Localfiles.salle_11,
      titleText: 'Coliseum',
      location: LatLng(51.516898, -0.143377),
      
      ),
      SalleListData(
      imagePath: Localfiles.salle_2,
      titleText: 'Coliseum',
      subText: 'wembley, Londre',
     
      ),
      SalleListData(
      imagePath: Localfiles.salle_3,
      titleText: 'Coliseum',
      
      ),
  ];

  static List<SalleListData> salleTypeList = [
     SalleListData(
      imagePath: Localfiles.salle_1,
      titleText: 'Coliseum',
      subText: 'wembley, Londre',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      isSelected: true,
      roomSizeText: '2100 personne',
      //location: LatLing
      ),
      SalleListData(
      imagePath: Localfiles.salle_3,
      titleText: 'Coliseum',
      
      ),
      SalleListData(
      imagePath: Localfiles.salle_4,
      titleText: 'Coliseum',
      subText: 'wembley, Londre',
     
      ),
      SalleListData(
      imagePath: Localfiles.salle_5,
      titleText: 'Coliseum',
      
      ),
  ];

  static List<SalleListData> salleList = [
    SalleListData(
      imagePath: Localfiles.salle_6,
      titleText: 'Coliseum',
      subText: 'wembley, Londre',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      isSelected: true,
      roomSizeText: '2100 personne',
      //location: LatLing
      ),
      SalleListData(
      imagePath: Localfiles.salle_1,
      titleText: 'Coliseum',
      
      ),
      SalleListData(
      imagePath: Localfiles.salle_7,
      titleText: 'Coliseum',
      subText: 'wembley, Londre',
     
      ),
      SalleListData(
      imagePath: Localfiles.salle_8,
      titleText: 'Coliseum',
      
      ),
      SalleListData(
      imagePath: Localfiles.salle_9,
      titleText: 'Coliseum',
     
      ),
  ];

   static List<SalleListData> popularList = [
    SalleListData(
      imagePath: Localfiles.salle_10,
      titleText: 'Coliseum',
      subText: 'wembley, Londre',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      isSelected: true,
      roomSizeText: '2100 personne',
      //location: LatLing
      ),
      SalleListData(
      imagePath: Localfiles.salle_11,
      titleText: 'Coliseum',
      
      ),
      SalleListData(
      imagePath: Localfiles.salle_1,
      titleText: 'Coliseum',
      subText: 'wembley, Londre',
     
      ),
      SalleListData(
      imagePath: Localfiles.salle_2,
      titleText: 'Coliseum',
      
      ),
      SalleListData(
      imagePath: Localfiles.salle_3,
      titleText: 'Coliseum',
     
      ),
  ];
  static List<SalleListData> reviewsList = [
    SalleListData(
      imagePath: Localfiles.avatar1,
      titleText: 'Alexia Jane',
      subText:
          'This is located in a great spot close to shops and bars, very quiet location',
      rating: 8.0,
      dateText: '21 May, 2019',
    ),
     SalleListData(
      imagePath: Localfiles.avatar2,
      titleText: 'Alexia Jane',
      subText:
          'This is located in a great spot close to shops and bars, very quiet location',
      rating: 8.0,
      dateText: '21 May, 2019',
    ),
     SalleListData(
      imagePath: Localfiles.avatar4,
      titleText: 'Alexia Jane',
      subText:
          'This is located in a great spot close to shops and bars, very quiet location',
      rating: 8.0,
      dateText: '21 May, 2019',
    ),
  ];


}


