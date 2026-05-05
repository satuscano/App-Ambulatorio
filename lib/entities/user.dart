class User {
  final int id;
  final String codiceFiscale;
  final String ruolo;

  User({
    required this.id,
    required this.codiceFiscale,
    required this.ruolo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      codiceFiscale: json['codiceFiscale'],
      ruolo: json['ruolo'],
    );
  }
}