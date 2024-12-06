import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Favoris'),
      ),
      body: FutureBuilder(
        future: StorageService.loadFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          final favorites = snapshot.data as List<Map<String, dynamic>>;
          if (favorites.isEmpty) {
            return const Center(
              child: Text('Aucun favori pour le moment.'),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final cocktail = favorites[index];
              return ListTile(
                leading: Image.network(cocktail['strDrinkThumb']),
                title: Text(cocktail['strDrink']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await StorageService.removeFavorite(cocktail['idDrink']);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Supprimé des favoris!')),
                    );
                    (context as Element).reassemble();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
