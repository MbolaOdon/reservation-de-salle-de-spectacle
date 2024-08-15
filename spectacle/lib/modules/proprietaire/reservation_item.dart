import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spectacle/api/reservation_service.dart';
import 'package:spectacle/config/config.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/models/reservation_model.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/providers/secure_storage.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/custom_toast.dart';

class ReservationItem extends StatefulWidget {
  final ReservationModelClient reservationModel;
  final Function(bool)? onCheckChanged;

  const ReservationItem({
    Key? key, 
    required this.reservationModel, 
    this.onCheckChanged
  }) : super(key: key);

  @override
  _ReservationItemState createState() => _ReservationItemState();
}

class _ReservationItemState extends State<ReservationItem> {
  bool isChecked = false;
  final ReservationService reservationService = ReservationService();
  final SecureStorage secureStorage = SecureStorage();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    userData = await secureStorage.getJsonData('user_data');
    setState(() {});
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
        onTap: () => viewMoreDetails(widget.reservationModel),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        tileColor: AppTheme.whiteColor,
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildClientInfo(),
            _buildReservationInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildClientInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Text('Salle', style: TextStyles(context).getBoldStyle().copyWith(fontSize: 16)),
        Text(widget.reservationModel.titre.toString(), style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text('Client', style: TextStyles(context).getBoldStyle().copyWith(fontSize: 16)),
        Text(widget.reservationModel.nomPrenom ?? ''),
        Text(widget.reservationModel.phone ?? ''),
        Text(widget.reservationModel.email ?? ''),
      ]
    );
  }

  Widget _buildReservationInfo() {
    return Column(
      children: [
        Text('Reservation', style: TextStyles(context).getBoldStyle().copyWith(fontSize: 16)),
        Text('De ${DateFormat('d MMMM yyy').format(widget.reservationModel.dateDebut ?? DateTime.now())}'),
        Text(' à ${DateFormat('d MMMM yyy').format(widget.reservationModel.dateFin ?? DateTime.now())}'),
        Text(
          widget.reservationModel.validation == 0 ? 'En attente' : 'Acceptée', 
          style: TextStyle(
            fontSize: 16, 
            color: widget.reservationModel.validation == 1 ? Colors.green : Colors.blueAccent
          )
        ),
        if (widget.reservationModel.validation == 0 && userData?['role'] == 'prop') ...[
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.green),
            onPressed: () => validateReservation(widget.reservationModel.idReserv),
            child: Row(
              children: [
                Icon(Icons.check_circle),
                SizedBox(width: 4),
                Text("Accepter"),
              ],
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              // Implement refusal logic here
            },
            child: Row(
              children: [
                Icon(Icons.cancel),
                SizedBox(width: 4),
                Text("Refuser"),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Future<void> viewMoreDetails(ReservationModelClient salleModel) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.info),
            Text("Details de réservation", style: TextStyle(fontSize: 14)),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSalleImage(),
                SizedBox(height: 2),
                Text(salleModel.titre ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Text(salleModel.subTitre ?? ''),
                SizedBox(height: 5),
                Text(salleModel.nomPrenom ?? ''),
                Text(salleModel.phone ?? ''),
                Text(salleModel.email ?? ''),
                SizedBox(height: 5),
                _buildReservationDetails(salleModel),
              ],
            ),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalleImage() {
    return Image.network(
      '${Config.BaseApiUrl}public/uploads/salles/${widget.reservationModel.design}',
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
    );
  }

  Widget _buildReservationDetails(ReservationModelClient salleModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Réservé pour une date :'),
        Text('De ${DateFormat('d MMMM yyy').format(salleModel.dateDebut ?? DateTime.now())}'),
        Text(' à ${DateFormat('d MMMM yyy').format(salleModel.dateFin ?? DateTime.now())}'),
        Text(salleModel.validation == 0 ? 'En attente de validation' : "Validée"),
      ],
    );
  }

  Future<void> validateReservation(int? idReserv) async {
    if (idReserv == null) return;
    
    bool isValidate = await reservationService.validate(idReserv);
    if (isValidate) {
      showToast("Validation avec succès", isSuccess: true);
    } else {
      showToast("Échec de la validation", isSuccess: false);
    }
  }

  void showToast(String message, {bool isSuccess = true}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width - 50,
        child: Center(
          child: CustomToast(
            message: message,
            icon: isSuccess ? Icons.check_circle : Icons.error,
            backgroundColor: isSuccess ? Colors.green : Colors.red,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 4), () {
      overlayEntry.remove();
    });
  }
}