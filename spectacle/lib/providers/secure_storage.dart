import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SecureStorage {
  final storage = FlutterSecureStorage();

  Future<void> saveJsonData(String key, Map<String, dynamic> jsonData) async {
    String jsonString = json.encode(jsonData);
    await storage.write(key: key, value: jsonString);
  }

  Future<Map<String, dynamic>?> getJsonData(String key) async {
    String? jsonString = await storage.read(key: key);
    if (jsonString != null) {
      return json.decode(jsonString);
    }
    return null;
  }

  Future<void> deleteData(String key) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAllData() async {
    await storage.deleteAll();
  }
}




// void main() async {
 
  
//   SecureStorage secureStorage = SecureStorage();

//   // Exemple de données JSON reçues de l'API
//   Map<String, dynamic> userData = {
//     'id': 1,
//     'name': 'John Doe',
//     'email': 'john@example.com',
//     'token': 'your_api_token_here'
//   };

//   // Sauvegarder les données
//   await secureStorage.saveJsonData('user_data', userData);

//   // Récupérer les données
//   Map<String, dynamic>? retrievedData = await secureStorage.getJsonData('user_data');
  
//   if (retrievedData != null) {
//     print('Données utilisateur récupérées : $retrievedData');
//   } else {
//     print('Aucune donnée utilisateur trouvée');
//   }

//   // Supprimer les données
//   // await secureStorage.deleteData('user_data');

//   // Supprimer toutes les données
//   // await secureStorage.deleteAllData();
// }

// // getBottomBarUI(BottomBarType bottomBarType) {
// //   return CommonCard(
// //     color: Color.fromARGB(255, 255, 88, 27),
// //     radius: 0,
// //     child: Column(
// //       children: [
// //         Row(
// //           children: [
// //           TabButtonUI(
// //             icon : Icons.search,
// //             isSelected: bottomBarType == BottomBarType.Explore,
// //             text: "explorer",
// //             onTap: () { tabClick(BottomBarType.Explore);},
// //           ),
// //           TabButtonUI(
// //             icon : Icons.heart_broken,
// //             isSelected: bottomBarType == BottomBarType.Trips,
// //             text: "trips",
// //             onTap: () {tabClick(BottomBarType.Trips);},
// //           ),
// //           TabButtonUI(
// //             icon : Icons.supervised_user_circle,
// //             isSelected: bottomBarType == BottomBarType.Profile,
// //             text: "profile",
// //             onTap: () {tabClick(BottomBarType.Profile);},
// //           ),
// //         ],
// //         ),
// //         SizedBox(
// //           height: MediaQuery.of(context).padding.bottom,
// //         )
// //       ],
// //     ),
// //     );
// // }