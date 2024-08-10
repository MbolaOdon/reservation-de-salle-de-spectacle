class ReservationModel{
  final int idReserv;
  final int? nbrPlace;
  final DateTime dateDebut;
  final DateTime? dateFin;
  final String validation;
  final int idSalle;
  final int idCli;
  final String? createDate;
  final String? updateDate;

  ReservationModel({
    required this.idReserv,
    this.nbrPlace,
    required this.dateDebut,
     this.dateFin,
    required this.validation,
    required this.idSalle,
    required this.idCli,
    this.createDate,
    this.updateDate,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      idReserv: json['idReserv'],
      nbrPlace: json['nbrPlace'],
      dateDebut: json['dateDebut'],
      dateFin: json['dateFin'],
      validation: json['validation'],
      idSalle: json['idSalle'],
      idCli: json['idCli'],
      createDate: json['create_date'],
      updateDate: json['update_date'],
      
    );
  }
  Map<String, dynamic> toJson() {
  return {
    'idReserv': idReserv,
      'nbrPlace': nbrPlace,
      'dateDebut': dateDebut.toIso8601String(),
      'dateFin': dateFin!.toIso8601String(),
      'validation': validation,
      'idSalle': idSalle,
      'idCli': idCli,
      'createDate': createDate,
      'updateDate':updateDate,
  };
  }
}

class ReservationModelClient{
   final int? idReserv;
  final int? nbrPlace;
  final DateTime? dateDebut;
  final DateTime? dateFin;
  final String? validation;
  final int? idSalle;
  final int? idCli;
  final String? nomPrenom;
  final String? design;
  final String? phone;
  final String? email;
  final String? subTitre;
  final String? titre;

   ReservationModelClient({
     this.idReserv,
     this.titre,
     this.subTitre,
     this.nomPrenom,
     this.phone,
     this.idSalle,
     this.validation,
    this.dateFin,
     this.nbrPlace,
     this.dateDebut,
     this.idCli,
     this.design,
     this.email
   

  });

  factory ReservationModelClient.fromJson(Map<String, dynamic> json) {
    return ReservationModelClient(
      idReserv: json['idReserv'],
      titre: json['titre'],
      subTitre: json['subTitre'],
      nomPrenom: json['nomPrenom'],
      phone: json['phone'],
      idSalle: json['idSalle'],
      validation: json['validation'],
      dateFin: json['dateFin'] ,
      dateDebut: json['dateDebut'],
      nbrPlace: json['nbrPlace'],
      idCli: json['idCli'],
      design: json['design'],
      email: json['email'],
    );
  }
  static List<ReservationModelClient> reservationList = [];

  Map<String, dynamic> toJson() {
  return {
    'idReserv': idReserv,
    'titre': titre,
    'subTitre': subTitre,
    'nomPrenom': nomPrenom,
    'phone': phone,
    'idSalle': idSalle,
    'validation': validation,
    'dateFin': dateFin,
    'nbrPlace': nbrPlace,
    'dateDebut': dateDebut,
    'idCli': idCli,
    'design':design,
    'email':email,

  };
}
}




class ReservationClient{
   final int? idReserv;
  final int? nbrPlace;
  final DateTime? dateDebut;
  final DateTime? dateFin;
  final String? validation;
  final int? idSalle;
  final int? idCli;
  final String? nomPrenom;
  final String? design;
  final String? phone;
  final String? email;
  final String? subTitre;
  final String? titre;
  final int? prix;

   ReservationClient({
     this.idReserv,
     this.titre,
     this.subTitre,
     this.nomPrenom,
     this.phone,
     this.idSalle,
     this.validation,
    this.dateFin,
     this.nbrPlace,
     this.dateDebut,
     this.idCli,
     this.design,
     this.email,
     this.prix,
   

  });

  factory ReservationClient.fromJson(Map<String, dynamic> json) {
    return ReservationClient(
      idReserv: json['idReserv'],
      titre: json['titre'],
      subTitre: json['subTitre'],
      nomPrenom: json['nomPrenom'],
      phone: json['phone'],
      idSalle: json['idSalle'],
      validation: json['validation'],
      dateFin: json['dateFin'] ,
      dateDebut: json['dateDebut'],
      nbrPlace: json['nbrPlace'],
      idCli: json['idCli'],
      design: json['design'],
      email: json['email'],
      prix: json['prix'],
    );
  }
  static List<ReservationClient> reservationList = [];

  Map<String, dynamic> toJson() {
  return {
    'idReserv': idReserv,
    'titre': titre,
    'subTitre': subTitre,
    'nomPrenom': nomPrenom,
    'phone': phone,
    'idSalle': idSalle,
    'validation': validation,
    'dateFin': dateFin,
    'nbrPlace': nbrPlace,
    'dateDebut': dateDebut,
    'idCli': idCli,
    'design':design,
    'email':email,
    'prix': prix,

  };
}
}