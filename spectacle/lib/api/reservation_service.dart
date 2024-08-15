import 'package:http/http.dart' as http;
import 'package:spectacle/config/config.dart';
import 'package:spectacle/models/reservation_model.dart';
import 'dart:convert';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/providers/secure_storage.dart';

class ReservationService {
  Future<bool> addReservation(int idSalle, DateTime startDate, DateTime endDate) async {
    try {
      final SecureStorage secureStorage = SecureStorage();
      Map? retrievedData = await secureStorage.getJsonData('user_data');
      int idClient = retrievedData?['idCli'] ?? 0;

      ReservationModel reservationModel = ReservationModel(
        idReserv: 0,
        dateDebut: startDate,
        validation: 'en attente',
        idCli: idClient,
        idSalle: idSalle,
        dateFin: endDate,
        createDate: DateTime.now().toString(),
      );

      final response = await http.post(
        Uri.parse('${Config.BaseApiUrl}/reservationController/add'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reservationModel.toJson()),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return true;
      } else if (response.statusCode == 400) {
        print(response.body);
        return false;
      } else {
        print(response.body);
        print(jsonEncode(reservationModel.toJson()));
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int?> deleteReservation(int reservationId) async {
    try {
      final response = await http.delete(
        Uri.parse('${Config.BaseApiUrl}/reservationController/destroy/$reservationId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      } else if (response.statusCode == 404) {
        print(response.body);
        return response.statusCode;
      } else {
        print(response.body);
        return response.statusCode;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }
  Future<bool> validate(int idReserv) async {
    try{
       

      final response = await http.put(
        Uri.parse('${Config.BaseApiUrl}/reservationController/validate/$idReserv'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return true;
      } else if (response.statusCode == 400) {
        print(response.body);
        return false;
      } else {
        print(response.body);
       
        return false;
      }
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<List<ReservationModel>?> getListReservation() async {
    try {
      final response = await http.get(Uri.parse('${Config.BaseApiUrl}/reservationController/getAll'));
      if (response.statusCode == 200) {
        print('Status code: ${response.statusCode}');
        List jsonResponse = jsonDecode(response.body);
        List<ReservationModel> listReserv = jsonResponse.map((model) => ReservationModel.fromJson(model)).toList();
        return listReserv;
      } else {
        print('Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<ReservationModel>?> getListReservationClient() async {
    try {
      final response = await http.get(Uri.parse('${Config.BaseApiUrl}/reservationController/getReservClient'));
      if (response.statusCode == 200) {
        print('Status code: ${response.statusCode}');
        List jsonResponse = jsonDecode(response.body);
        List<ReservationModel> listReserv = jsonResponse.map((model) => ReservationModel.fromJson(model)).toList();
        return listReserv;
      } else {
        print('Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}