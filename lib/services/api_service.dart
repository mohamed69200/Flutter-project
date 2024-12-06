import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';

  static Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/list.php?c=list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['drinks'];
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  static Future<List<dynamic>> fetchCocktails(String category) async {
    final response =
        await http.get(Uri.parse('$baseUrl/filter.php?c=$category'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['drinks'];
    } else {
      throw Exception('Failed to fetch cocktails');
    }
  }

  static Future<Map<String, dynamic>> fetchCocktailDetails(
      String cocktailId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/lookup.php?i=$cocktailId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['drinks'][0];
    } else {
      throw Exception('Failed to fetch cocktail details');
    }
  }
}
