import 'package:flutter/material.dart';
import 'package:spectacle/api/reservation_service.dart';
import 'package:spectacle/api/salle_service.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/reservation_model.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';

class ReservationItem extends StatefulWidget {
  final ReservationModelClient reservationModel;
  final Function(bool)? onCheckChanged;

  ReservationItem({Key? key, required this.reservationModel, this.onCheckChanged}) : super(key: key);

  @override
  _ReservationItemState createState() => _ReservationItemState();
}

class _ReservationItemState extends State<ReservationItem> {
  bool isChecked = false;
  late ReservationService salleService;

  @override
  void initState() {
    super.initState();
    salleService = ReservationService();
  }

  // void onDelete(SalleModel salleModel) async {
  //   int result = await salleService.delete(salleModel);
  //   Navigator.of(context).pop();
  //   if (result == 200) {
  //     _notification('Suppression avec succès', Icons.notification_add_rounded, Colors.green);
  //   } else if (result == 404) {
  //     _notification('Salle n\'existe pas', Icons.notification_add_rounded, Colors.blueAccent);
  //   } else {
  //     _notification('Erreur survenue', Icons.notification_add_rounded, Colors.red);
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: AppTheme.lightSecondaryBackground,
          offset: Offset(0.0, 0.0),
          blurRadius: 10.0,
          spreadRadius: 0.0
        )
      ]
     ),
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.threeLine,
        onLongPress: () {
          setState(() {
            isChecked = !isChecked;
          });
          if (widget.onCheckChanged != null) {
            widget.onCheckChanged!(isChecked);
          }
        },
        onTap: (){
          viewMoreDetails(widget.reservationModel);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        tileColor: AppTheme.whiteColor,
        leading: Icon(
          isChecked ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          widget.reservationModel.titre.toString(),
          style: TextStyle(fontSize: 14),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.reservationModel.nomPrenom!),
            Text(widget.reservationModel.phone!),
            Text('${widget.reservationModel.email}'),
            Text('${widget.reservationModel.dateDebut}'),
            Text('${widget.reservationModel.dateFin}'),
            Text(widget.reservationModel.validation == 0 ? 'En attente' : 'Accepter'),
          ],
        ),
        trailing: Container(
          height: 28,
          width: 80,
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.circular(5),
          ),
          child:  Row(
            children: [
              IconButton(
                icon: Icon(Icons.check_circle),
                color: Colors.blueAccent,
                iconSize: 16,
                onPressed:  () {
                 // NavigationServices(context).gotoSalleForm(widget.salleModel);
                },
                ),
              SizedBox(width: 2,),
              IconButton(
                icon: Icon(Icons.close_rounded),
                color: Colors.red,
                iconSize: 16,
                onPressed: () {
                 // _showDeleteDialog(widget.salleModel);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(SalleModel salleModel) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations(context).of('are_you_sure_to_want_to_delete?')),
      actions: [
        TextButton(onPressed: () { Navigator.of(context).pop(); }, child: const Text('Non')),
        TextButton(onPressed: () { //onDelete(salleModel); 
        }, child: const Text('Oui'))
      ],
    )
  );

  void _notification(String message, IconData icon, Color gravityColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 3000),
        showCloseIcon: true,
        closeIconColor: AppTheme.primaryColor,
        content: Row(
          children: [
            Icon(icon, color: gravityColor),
            SizedBox(width: 10),
            Text(message, style: TextStyle(color: AppTheme.primaryTextColor)),
          ],
        )
      )
    );
  }
  
  Future<void> viewMoreDetails(ReservationModelClient salleModel) =>
    showDialog(
      context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      icon: Icon(Icons.info),
      title: Row(
        children: [
          
          Text("Information"),
        ],
      ),

      content:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(salleModel.titre.toString()),
          Text(salleModel.subTitre.toString()),
          Text('${salleModel.nomPrenom}'),
          Text('${salleModel.phone}'),
          Text(salleModel.email.toString()),
          Text('${salleModel.validation}'),
          Row(
            children: [
               Text('${salleModel.dateDebut}'),
          Text('${salleModel.dateFin}'),
            ],
          )
         
          //Text('${salleModel.longLatitude}')
        ],
       ),
       
      
      actions: [TextButton(onPressed: (){
        Navigator.of(context).pop();
      }, child: Row(
        children: [
          Icon(Icons.arrow_left),
          Text(AppLocalizations(context).of('close'))
        ],
      ))],
    )
    );
  
}