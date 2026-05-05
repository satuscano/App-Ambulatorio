class Paziente {
  final String codiceFiscale;
  final String nome;
  final String cognome;
  final String dataNascita;
  final String? anamnesi;
  final String? indCap;
  final String? indCitta;
  final String? indVia;
  final String? indCivico;

  Paziente({
    required this.codiceFiscale,
    required this.nome,
    required this.cognome,
    required this.dataNascita,
    this.anamnesi,
    this.indCap,
    this.indCitta,
    this.indVia,
    this.indCivico,
  });

  factory Paziente.fromJson(Map<String, dynamic> json) {
    return Paziente(
      codiceFiscale: json['codiceFiscale'],
      nome: json['nome'],
      cognome: json['cognome'],
      dataNascita: json['dataNascita'],
      anamnesi: json['anamnesi'],
      indCap: json['ind_cap'],
      indCitta: json['ind_citta'],
      indVia: json['ind_via'],
      indCivico: json['ind_civico'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codiceFiscale': codiceFiscale,
      'nome': nome,
      'cognome': cognome,
      'dataNascita': dataNascita,
      'anamnesi': anamnesi,
      'ind_cap': indCap,
      'ind_citta': indCitta,
      'ind_via': indVia,
      'ind_civico': indCivico,
    };
  }

  String get fullName => '$nome $cognome';
}