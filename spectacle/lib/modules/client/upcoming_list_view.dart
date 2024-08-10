import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spectacle/config/config.dart';
import 'package:spectacle/models/reservation_model.dart';
import 'package:http/http.dart' as http;
import 'package:spectacle/providers/secure_storage.dart';
import 'package:spectacle/routes/route_names.dart';


class UpcomingListView extends StatefulWidget {
  final AnimationController animationController;

  const UpcomingListView({Key? key, required this.animationController})
      : super(key: key);
  @override
  _UpcomingListViewState createState() => _UpcomingListViewState();
}

class _UpcomingListViewState extends State<UpcomingListView> with SingleTickerProviderStateMixin{

late AnimationController _animationController;
final SecureStorage secureStorage = SecureStorage();
List<ReservationClient> userdata = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animationController.forward();
    fetchData();
  }

 void fetchData() async {
  Map<String, dynamic>? retrievedData = await secureStorage.getJsonData('user_data');
  String uri = "${Config.BaseApiUrl}reservationController/getReservClient/${retrievedData!['idCli']}";
  try {
    var response = await http.get(Uri.parse(uri));
    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      String responseBody = response.body;
      if (responseBody.contains("reservationController")) {
        responseBody = responseBody.substring(responseBody.indexOf('['));
      }
      List<dynamic> decodedData = jsonDecode(responseBody);
      setState(() {
        userdata = decodedData.map((json) => ReservationClient.fromJson(json)).toList();
        isLoading = false;
      });
    }
  } catch (e) {
    print("Error: $e");
    // setState(() {
    //   isLoading = false;
    // });
  }
}

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réservations'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: userdata.length,
        itemBuilder: (context, index) {
          final reservation = userdata[index];
          return FadeTransition(
            opacity: _animationController,
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 8,
              shadowColor: Colors.tealAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                leading: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Text(
                    reservation.nomPrenom?[0] ?? '?',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                title: Text(
                  reservation.titre ?? 'Titre',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.teal,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(reservation.subTitre ?? 'Sous-titre'),
                    SizedBox(height: 5),
                    Text(
                      'Date: ${DateFormat('dd/MM/yyyy').format(reservation.dateDebut!)} - ${DateFormat('dd/MM/yyyy').format(reservation.dateFin!)}',
                    ),
                    Text('Nombre de places: ${reservation.nbrPlace}'),
                    Text('Client: ${reservation.nomPrenom}'),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${reservation.prix} \$',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      reservation.validation == 1 ? 'Validé' : 'Non validé',
                      style: TextStyle(
                        color: reservation.validation == 'oui'
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
