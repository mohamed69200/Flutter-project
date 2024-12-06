import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cocktailId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Cocktail'),
      ),
      body: FutureBuilder(
        future: ApiService.fetchCocktailDetails(cocktailId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          final cocktail = snapshot.data as Map<String, dynamic>;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(cocktail['strDrinkThumb']),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cocktail['strDrink'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Catégorie: ${cocktail['strCategory']}\nType: ${cocktail['strAlcoholic']}',
                      ),
                      const SizedBox(height: 10),
                      Text('Instructions: ${cocktail['strInstructions']}'),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await StorageService.saveFavorite(cocktail);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Ajouté aux favoris!')),
                          );
                        },
                        icon: const Icon(Icons.favorite),
                        label: const Text('Ajouter aux favoris'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
