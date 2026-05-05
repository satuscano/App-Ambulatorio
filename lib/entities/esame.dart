class Esame {
  final int codiceEsame;
  final int codiceAmbulatorio;
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