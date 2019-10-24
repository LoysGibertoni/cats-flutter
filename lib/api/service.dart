import 'dart:convert';

import 'package:cats/api/breed.dart';
import 'package:http/http.dart' as http;

class Service {
  static const String url = 'api.thecatapi.com';
  static const String apiKey = '730b041c-83c6-4617-9ca4-657ad0005b74';

  static Future<List<Breed>> getBreeds() async {
    final response = await http.get(Uri.https(url, '/v1/breeds'), headers: {'x-api-key': apiKey});
    if (response.statusCode == 200) {
      final Iterable list = json.decode(response.body);
      return list.map((item) => Breed.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load breeds');
    }
  }

  static Future<String> getImage(Breed breed) async {
    final response = await http.get(Uri.https(url, '/v1/images/search', {'breed_id': breed.id}), headers: {'x-api-key': apiKey});
    if (response.statusCode == 200) {
      final Iterable list = json.decode(response.body);
      return list.first['url'];
    } else {
      throw Exception('Failed to load breed image');
    }
  }
}