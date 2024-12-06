import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: FutureBuilder(
        future: ApiService.fetchCocktails(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          final cocktails = snapshot.data as List<dynamic>;
          return ListView.builder(
            itemCount: cocktails.length,
            itemBuilder: (context, index) {
              final cocktail = cocktails[index];
              return ListTile(
                leading: Image.network(cocktail['strDrinkThumb']),
                title: Text(cocktail['strDrink']),
                onTap: () {
                  Navigator.pushNamed(context, '/details',
                      arguments: cocktail['idDrink']);
                },
              );
            },
          );
        },
      ),
    );
  }
}
