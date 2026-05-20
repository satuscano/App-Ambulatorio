import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entities/esame.dart';
import '../entities/paziente.dart';

class ApiService {
  static const String baseUrl =
      'http://satuscano.altervista.org/api.php';

  static Future<List<Esame>?> getEsami() async {
    final url = Uri.parse('$baseUrl?action=getEsami');

    try {
      // await serve per ottenere la risposta dal server prima di procedere
      final response = await http.get(url);

      // se il serve da l'ok (200) decodifica il json e crea una lista di esami
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // decodifica il json
        final list = (data['esami'] as List)
            .map((e) => Esame.fromJson(e)) // .map: da json a Esame
            .toList(); // .toList: da Iterable (map) a List (array di esami)

        return list;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteEsame(int id) async {
    final url = Uri.parse('$baseUrl?action=deleteEsame&id=$id');

    try {
      final response = await http.get(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<int> addEsame(Esame esame) async {
    final url = Uri.parse('$baseUrl?action=addEsame');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(esame.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['id'] ?? -1;
      }

      return -1;
    } catch (e) {
      return -1;
    }
  }

  static Future<bool> updateEsame(Esame esame) async {
    final url = Uri.parse('$baseUrl?action=updateEsame');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(esame.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Paziente>?> getPazienti() async {
    final url = Uri.parse('$baseUrl?action=getPazienti');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final list = (data['pazienti'] as List)
            .map((e) => Paziente.fromJson(e))
            .toList();

        return list;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> login(
      String codiceFiscale, String password) async {
    final url = Uri.parse('$baseUrl?action=login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'codiceFiscale': codiceFiscale,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}