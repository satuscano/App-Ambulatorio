class Esame {
  final String codiceEsame;
  final String codiceAmbulatorio;
  final String codiceMedico;
  final String codiceFiscale;
  final String diagnosi;
  final String referto;

  Esame({
    required this.codiceEsame,
    required this.codiceAmbulatorio,
    required this.codiceMedico,
    required this.codiceFiscale,
    required this.diagnosi,
    required this.referto,
  });

  // la factory serve per creare un oggetto Esame a partire da una mappa (come json)
  factory Esame.fromJson(Map<String, dynamic> json) {
    return Esame(
      codiceEsame: json['codiceEsame'],
      codiceAmbulatorio: json['codiceAmbulatorio'],
      codiceMedico: json['codiceMedico'],
      codiceFiscale: json['codiceFiscale'],
      diagnosi: json['diagnosi'] ?? '',
      referto: json['referto'] ?? '',
    );
  }

  // la Map serve a convertire un oggetto Esame in una mappa (contrario di factory)
  Map<String, dynamic> toJson() {
    return {
      'codiceEsame': codiceEsame,
      'codiceAmbulatorio': codiceAmbulatorio,
      'codiceMedico': codiceMedico,
      'codiceFiscale': codiceFiscale,
      'diagnosi': diagnosi,
      'referto': referto,
    };
  }
}