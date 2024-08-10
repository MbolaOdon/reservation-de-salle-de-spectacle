class SalleModel {
  final int idSalle;
  final String titre;
  final String subTitre;
  final String description;
  final double prix;
  final int? occupation;
  final String localName;
  final double? longLatitude;
  final int nbrPlace;
  final int star;
  final String typeSalle;
  final int idPro;
  final String? createDate;
  final String? updateDate;
  final String? path_image;

  SalleModel({
    required this.idSalle,
    required this.titre,
    required this.subTitre,
    required this.description,
    required this.prix,
     this.occupation,
    required this.localName,
    this.longLatitude,
    required this.nbrPlace,
    required this.star,
    required this.typeSalle,
    required this.idPro,
     this.createDate,
    this.updateDate,
    this.path_image
  });

  factory SalleModel.fromJson(Map<String, dynamic> json) {
    return SalleModel(
      idSalle: json['idSalle'],
      titre: json['titre'],
      subTitre: json['subTitre'],
      description: json['Description'],
      prix: (json['prix'] as num).toDouble(),
      occupation: json['occupation'],
      localName: json['localName'],
      longLatitude: json['longLatitude'] != null ? (json['longLatitude'] as num).toDouble() : null,
      nbrPlace: json['nbrPlace'],
      star: json['star'],
      typeSalle: json['typeSalle'],
      idPro: json['idPro'],
      createDate: json['create_date'],
      updateDate: json['update_date'],
      path_image: json['path_image']
    );
  }
  static List<SalleModel> salleList = [];

  Map<String, dynamic> toJson() {
  return {
    'idSalle': idSalle,
    'titre': titre,
    'subTitre': subTitre,
    'Description': description,
    'prix': prix,
    'occupation': occupation,
    'localName': localName,
    'longLatitude': longLatitude,
    'nbrPlace': nbrPlace,
    'star': star,
    'typeSalle': typeSalle,
    'idPro': idPro,
    'create_date': createDate,
    'update_date': updateDate,
    'path_image': path_image,
  };
}
}

class SalleModelClient {
  final int idSalle;
  final String titre;
  final String subTitre;
  final String description;
  final double prix;
  final int? occupation;
  final String localName;
  final double? longLatitude;
  final int nbrPlace;
  final int star;
  final String typeSalle;
  final int idPro;
  final int? idPho;
  final String design;
  final String? interne_design;


  SalleModelClient({
    required this.idSalle,
    required this.titre,
    required this.subTitre,
    required this.description,
    required this.prix,
     this.occupation,
    required this.localName,
    this.longLatitude,
    required this.nbrPlace,
    required this.star,
    required this.typeSalle,
    required this.idPro,
    this.idPho,
    required this.design,
    this.interne_design, 

  });

  factory SalleModelClient.fromJson(Map<String, dynamic> json) {
    return SalleModelClient(
      idSalle: json['idSalle'],
      titre: json['titre'],
      subTitre: json['subTitre'],
      description: json['Description'],
      prix: (json['prix'] as num).toDouble(),
      occupation: json['occupation'],
      localName: json['localName'],
      longLatitude: json['longLatitude'] != null ? (json['longLatitude'] as num).toDouble() : null,
      nbrPlace: json['nbrPlace'],
      star: json['star'],
      typeSalle: json['typeSalle'],
      idPro: json['idPro'],
      idPho: json['idPho'],
      design: json['design'],
      interne_design: json['interne_design']

    );
  }
  static List<SalleModelClient> salleList = [];

  Map<String, dynamic> toJson() {
  return {
    'idSalle': idSalle,
    'titre': titre,
    'subTitre': subTitre,
    'Description': description,
    'prix': prix,
    'occupation': occupation,
    'localName': localName,
    'longLatitude': longLatitude,
    'nbrPlace': nbrPlace,
    'star': star,
    'typeSalle': typeSalle,
    'idPro': idPro,
     'idPho': idPho,
    'design':design,
    'interne_design':interne_design,

  };
}
}