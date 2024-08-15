import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spectacle/api/salle_service.dart';
import 'package:spectacle/config/config.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:http/http.dart' as http;

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
  late SalleModelClient salle = SalleModelClient(idSalle: 0, titre: '', subTitre: '', description: '', prix: 0, localName: '', nbrPlace: 0, star: 0, typeSalle: '', idPro: 0, design: ''); // Initialisation correcte

  @override
  void initState() {
    super.initState();
    salleService = SalleService();
  }

  Future<void> onDelete(SalleModel salleModel) async {
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

  Future<void> viewSalleDetails(int id) async {
    String uri = "${Config.BaseApiUrl}/salleController/getSalleDetails/$id";
    try {
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        String responseBody = response.body;
        if (responseBody.contains("salleController")) {
          responseBody = responseBody.substring(responseBody.indexOf('['));
        }
        List<dynamic> decodedData = jsonDecode(responseBody);
        if (decodedData.isNotEmpty) {
          setState(() {
            salle = SalleModelClient.fromJson(decodedData.first);
          });
        }
      }
    } catch (e) {
      print("Error: $e");
    }
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
          widget.onCheckChanged?.call(isChecked);
        },
        onTap: () => viewMoreDetails(widget.salleModel.idSalle),
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
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blueAccent, size: 18),
                onPressed: () => NavigationServices(context).gotoSalleForm(widget.salleModel, 'edit'),
              ),
              SizedBox(width: 2),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red, size: 18),
                onPressed: () => _showDeleteDialog(widget.salleModel),
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
      title: Text("Vous êtes sûr de vouloir supprimer ?"),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Non')),
        TextButton(onPressed: () => onDelete(salleModel), child: const Text('Oui'))
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
  
  Future<void> viewMoreDetails(int id) async {
    await viewSalleDetails(id);
    
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
        content: SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                '${Config.BaseApiUrl}public/uploads/salles/${salle.design}',
                width: 150,
                height: 100,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
              Text(salle.titre ?? ''),
              Text(salle.subTitre ?? ''),
              Text('${salle.prix ?? ''}'),
              Text(salle.occupation == 0 ? 'Libre' : 'Occupée'),
              Text(salle.description ?? ''),
              Text('${salle.star ?? ''}'),
              Text(salle.localName ?? ''),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              children: [
                Icon(Icons.arrow_left),
                Text(AppLocalizations(context).of('close'))
              ],
            )
          )
        ]
      )
    );
  }
}