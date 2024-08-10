class ReservationDetails {
  late String security;
  late bool organisateur;
  late DateTime? dateDebut, dateFin;
  late int? idCli, idSalle;
 
  ReservationDetails({
   this.security = '',
   this.organisateur = false,
    this.dateDebut ,
   this.dateFin ,
   this.idCli,
   this.idSalle,
  
  });
}