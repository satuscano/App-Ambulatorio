import 'dart:convert';

import 'package:http/http.dart' as http;

import 'entities/esame.dart';

const baseURL = 'http://satuscano.altervista.org/api.php?format=json';

class WebApi {
  static Future<List<Esame>?> getEsami() async {
    final url = Uri.parse(baseURL);
    print(url);
    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        final jsonResponse = jsonDecode(response.body);
        final jsonEsami = jsonResponse['esami'] as List;

        final listEsami = jsonEsami
            .map((elEsame) => Esame.fromJson(elEsame))
            .toList();
        return listEsami;
        
      } else{
        return null;
      }
    } catch(ex){
      print(ex);
      return null;
    }
  }
  
  static Future<bool> deleteEsame(int id) async {
    final url = Uri.parse('$baseURL?id=$id');
    try{
      final response = await http.delete(url);
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    }catch(ex){
      return false;
    }
  }

  static Future<bool> updateEsame(Esame esame) async{
    try{
      final url = Uri.parse('$baseURL?id=${esame.codiceEsame}');
      final body = esame.toJson();
      final response = await http.put(url, body: body);
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    }catch(ex){
      return false;
    }
  }

  static Future<int> nuovoEsame(Esame esame) async{
    try{
      final url = Uri.parse(baseURL);
      final body = esame.toJson();
      final response = await http.post(url, body: body);
      if(response.statusCode == 200){
        return int.tryParse(response.body) ?? -1;
      }else{
        return -1;
      }
    }catch(ex){
      return -1;
    }
  }
}