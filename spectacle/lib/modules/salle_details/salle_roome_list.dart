import 'package:flutter/material.dart';
import 'package:spectacle/utils/localfiles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/common_card.dart';

class SalleRoomeList extends StatefulWidget {
  @override
  _SalleRoomeListState createState() => _SalleRoomeListState();
}

class _SalleRoomeListState extends State<SalleRoomeList> {
  List<String> photosList = [
    Localfiles.salle_1,
    Localfiles.salle_10,
    Localfiles.salle_2,
    Localfiles.salle_3,
    Localfiles.salle_4,
    Localfiles.salle_5,
    Localfiles.salle_6,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 8, right: 16, left: 16),
        itemCount: photosList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    photosList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
