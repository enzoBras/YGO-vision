import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestApi {

  Future<Map<String, dynamic>> getAllCards() async {
    var url = Uri.https("db.ygoprodeck.com", "api/v7/cardinfo.php", {'language': 'fr'});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur lors du GET de l\'api');
    }
  }

  Future<Map<String, dynamic>> searchByName(String name) async {
    var url = Uri.https("db.ygoprodeck.com", "api/v7/cardinfo.php", {'language': 'fr', 'name': name});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur lors du GET de l\'api');
    }
  }
}