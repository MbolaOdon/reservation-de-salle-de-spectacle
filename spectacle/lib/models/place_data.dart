class PlaceData {
  late String  titleText, subText;
 
  late String dateText,roomSizeText;
 
  late double dist, rating;
  late int numblerPlace;
  late bool isSelected;
 
  

 PlaceData({
    
    this.titleText = '',
    this.subText = '',
   
    this.dateText = '',
    this.roomSizeText = '',
    this.dist = 2.0,
    this.rating = 4.4,
    this.numblerPlace = 0,
    this.isSelected = false,
  
  

    


  });
  static List<PlaceData> PlaceList = [
     PlaceData(
     
      titleText: 'Coliseum',
      subText: 'wembley, Londre',
      dist: 2.0,
     numblerPlace: 80,
      rating: 4.4,
      isSelected: true,
      roomSizeText: '2100 personne',
      //location: LatLing
      ),
     
  ];
}