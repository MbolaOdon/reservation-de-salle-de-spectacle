import 'package:flutter/material.dart';
import 'package:spectacle/api/salle_service.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';

class SalleItem extends StatefulWidget {
  final SalleModel salleModel;
  final Function(bool)? onCheckChanged;

  SalleItem({Key? key, required this.salleModel, this.onCheckChanged}) : super(key: key);

  @override
  _SalleItemState createState() => _SalleItemState();
}

class _SalleItemState extends State<SalleItem> {
  bool isChecked = false;
  late SalleService salleService;

  @override
  void initState() {
    super.initState();
    salleService = SalleService();
  }

  void onDelete(SalleModel salleModel) async {
    int result = await salleService.delete(salleModel);
    Navigator.of(context).pop();
    if (result == 200) {
      _notification('Suppression avec succès', Icons.notification_add_rounded, Colors.green);
    } else if (result == 404) {
      _notification('Salle n\'existe pas', Icons.notification_add_rounded, Colors.blueAccent);
    } else {
      _notification('Erreur survenue', Icons.notification_add_rounded, Colors.red);
    }
  }

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
          viewMoreDetails(widget.salleModel);
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
          widget.salleModel.titre,
          style: TextStyle(fontSize: 14),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.salleModel.subTitre),
            Text(widget.salleModel.occupation == 0 ? 'Disponible' : 'Deja réserver'),
            Text('${widget.salleModel.prix}'),
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
                icon: Icon(Icons.edit),
                color: Colors.blueAccent,
                iconSize: 16,
                onPressed:  () {
                  NavigationServices(context).gotoSalleForm(widget.salleModel, 'edit');
                },
                ),
              SizedBox(width: 2,),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                iconSize: 16,
                onPressed: () {
                  _showDeleteDialog(widget.salleModel);
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
      title: Text("Vous etes sur de vouloir supprimer"
        //AppLocalizations(context).of('are_you_sure_to_want_to_delete?')
        ),
      actions: [
        TextButton(onPressed: () { Navigator.of(context).pop(); }, child: const Text('Non')),
        TextButton(onPressed: () { onDelete(salleModel); }, child: const Text('Oui'))
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
  
  Future<void> viewMoreDetails(SalleModel salleModel) =>
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
          Text(salleModel.titre),
          Text(salleModel.subTitre),
          Text('${salleModel.prix}'),
          Text('${salleModel.occupation}'),
          Text(salleModel.description),
          Text('${salleModel.star}'),
          Text('${salleModel.localName}'),
          
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