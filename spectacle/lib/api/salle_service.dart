import 'package:http/http.dart' as http;
import 'package:spectacle/config/config.dart';
import 'dart:convert';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/providers/secure_storage.dart';


class SalleService {
  int? id;
  bool isLoading = true;
  String error = '';
  List<SalleModel> salleList = [];

  SalleModel salleModel = SalleModel(
    idSalle: 0,  // Added this field as it's required in the model
    titre: '',
    subTitre: '',
    description: '',
    prix: 0,
    occupation: 0,  // Changed to int as per the model
    localName: '',
    nbrPlace: 0,
    star: 0,
    typeSalle: '',
    idPro: 0,
    createDate: '',  // Added this field as it's required in the model
  );

  Future<bool> add(SalleModel salleModel) async {
    try{
      final SecureStorage secureStorage = SecureStorage();
    final response = await http.post(
      Uri.parse('${Config.BaseApiUrl}/salleController/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(salleModel.toJson()),
    );

    if (response.statusCode == 201) {
       final data = jsonDecode(response.body);
       Map<String, dynamic>? salleData = json.decode(response.body);
       await secureStorage.saveJsonData('salle_data', salleData!);
         
      return true;
    } else if (response.statusCode == 400) {
      print(response.body);
      return false;
    } else {
      print(response.body);
      print(jsonEncode(salleModel.toJson()));
      return false;
      //throw Exception('Failed to add Salle');
    }}catch(e){print(e); return false;}
  }

  
  Future<bool> update(SalleModel salleModel) async {
    if (id == null) {
      throw Exception('ID is not set');
    }
    final response = await http.put(
      Uri.parse('${Config.BaseApiUrl}/salleController/update/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(salleModel.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400 || response.statusCode == 500) {
      print(response.body);
      return false;
    } else {
      throw Exception('Failed to update Salle');
    }
  }

  Future<int> delete(SalleModel salleModel) async {
     try{
    final response = await http.delete(
      Uri.parse('${Config.BaseApiUrl}/salleController/destroy/${salleModel.idSalle}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
    );

    if (response.statusCode == 200) {
      return response.statusCode ;
    } else if (response.statusCode == 404) {
      print(response.body);
      return response.statusCode ;
    } else {
      print(response.body);
      print(jsonEncode(salleModel.toJson()));
      return response.statusCode ;
      //throw Exception('Failed to add Salle');
    }}catch(e){print(e); return 0;}
  }

  Future<List<SalleModel>> getListSalle() async {
    try {
      final response = await http.get(Uri.parse('${Config.BaseApiUrl}/salleController/getAll'));
      
      if (response.statusCode == 200) {
        print('Status code: ${response.statusCode}');
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<SalleModel> listSalle = jsonResponse.map((model) => SalleModel.fromJson(model)).toList();
        return listSalle;
      } else {
        print('Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
  Future<List<SalleModelClient>> getListViewSalle() async {
    try {
      final response = await http.get(Uri.parse('${Config.BaseApiUrl}/salleController/getViewSalle'));
      
      if (response.statusCode == 200) {
        print('Status code: ${response.statusCode}');
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<SalleModelClient> listSalle = jsonResponse.map((model) => SalleModelClient.fromJson(model)).toList();
        return listSalle;
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