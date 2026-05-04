class Esame{
  final int codiceEsame;
  final int codiceAmbulatorio;
  final String codiceMedico;
  final String codiceFiscale;
  final String diagnosi;
  final String referto;

  Esame(
    {
      required this.codiceEsame,
      required this.codiceAmbulatorio,
      required this.codiceMedico,
      required this.codiceFiscale,
      required this.diagnosi,
      required this.referto
    }
  );

  factory Esame.fromJson(Map<String, dynamic> jsonMap){
    return Esame(
      codiceEsame: int.parse(jsonMap['codiceEsame']),
      codiceAmbulatorio: int.parse(jsonMap['codiceAmbulatorio']),
      codiceMedico: jsonMap['codiceMedico'],
      codiceFiscale: jsonMap['codiceFiscale'],
      diagnosi: jsonMap['diagnosi'],
      referto: jsonMap['referto']
    );
  }

  String toJson(){
    return '{"codiceEsame":$codiceEsame, "codiceAmbulatorio":$codiceAmbulatorio, "codiceMedico":"$codiceMedico", "codiceFiscale":"$codiceFiscale", "diagnosi":"$diagnosi", "referto":"$referto"}';
  }

  Esame getEsame(){
    return Esame(
      codiceEsame: codiceEsame,
      codiceAmbulatorio: codiceAmbulatorio,
      codiceMedico: codiceMedico,
      codiceFiscale: codiceFiscale,
      diagnosi: diagnosi,
      referto: referto
    );
  }
}