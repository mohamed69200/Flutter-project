import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String favoritesKey = 'favoriteCocktails';

  static Future<List<Map<String, dynamic>>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final storedFavorites = prefs.getString(favoritesKey);
    if (storedFavorites != null) {
      return List<Map<String, dynamic>>.from(json.decode(storedFavorites));
    }
    return [];
  }

  static Future<void> saveFavorite(Map<String, dynamic> cocktail) async {
    final favorites = await loadFavorites();
    favorites.add(cocktail);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(favoritesKey, json.encode(favorites));
  }

  static Future<void> removeFavorite(String cocktailId) async {
    final favorites = await loadFavorites();
    final updatedFavorites =
        favorites.where((fav) => fav['idDrink'] != cocktailId).toList();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(favoritesKey, json.encode(updatedFavorites));
  }
}
