import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spectacle/config/config.dart';
import 'package:spectacle/models/login_model.dart';
import 'package:spectacle/providers/secure_storage.dart';

class AuthService {
  String cleanResponse(String response) {
    final regex = RegExp(r'<br />.*?<br />');
    return response.replaceAll(regex, '');
  }

  Future<Object> login(LoginRequestModel requestModel) async {
    try {
      final response = await http.post(
        Uri.parse('${Config.BaseApiUrl}authController/login'),
        body: requestModel.toJson(),
      );

      var cleanedResponse = cleanResponse(response.body);
      var jsonResponse = json.decode(cleanedResponse);

      if (response.statusCode == 200) {
        SecureStorage secureStorage = SecureStorage();
        await secureStorage.saveJsonData('user_data', jsonResponse);
        return true;
      } else if (response.statusCode == 400) {
        return LoginResponseModel.fromJson(jsonResponse);
      } else if (response.statusCode == 404) {
        final response2 = await http.post(
          Uri.parse('${Config.BaseApiUrl}proprietaireController/login'),
          body: requestModel.toJson(),
        );

        var cleanedResponse2 = cleanResponse(response2.body);
        var jsonResponse2 = json.decode(cleanedResponse2);

        if (response2.statusCode == 200) {
          SecureStorage secureStorage = SecureStorage();
          await secureStorage.saveJsonData('user_data', jsonResponse2);
          return true;
        } else if (response2.statusCode == 400) {
          return LoginResponseModel.fromJson(jsonResponse2);
        } else {
          throw Exception('Failed to login: ${cleanedResponse2}');
        }
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }
}