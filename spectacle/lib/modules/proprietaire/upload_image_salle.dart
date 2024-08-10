import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'package:spectacle/config/config.dart';
import 'package:spectacle/providers/secure_storage.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  late final SecureStorage secureStorage = SecureStorage();

  Future<void> _pickImage() async {
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        _imageFile = selectedImage;
      });
    }
  }

  Future<void> _uploadImage() async {
    Map<String, dynamic>? retrievedData = await secureStorage.getJsonData('salle_data');
    String id = retrievedData!['id'].toString();

    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner une image')),
      );
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Config.BaseApiUrl}salleController/uploadSalle/${id}'),
    );

    var file = await http.MultipartFile.fromPath(
      'image',
      _imageFile!.path,
    );
    request.files.add(file);

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image téléchargée avec succès')),
        );
        print(jsonResponse);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: ${response.body}')),
        );
      }
    } catch (e) {
      print('Erreur: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une erreur est survenue: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Télécharger une image'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Sélectionner une image'),
          ),
          _imageFile != null
              ? Image.file(
                  File(_imageFile!.path),
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Container(),
          ElevatedButton(
            onPressed: _uploadImage,
            child: Text('Télécharger l\'image'),
          ),
        ],
      ),
    );
  }
}
