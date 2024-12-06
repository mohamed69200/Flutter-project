import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/category_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/favorites_screen.dart';

void main() {
  runApp(const CocktailApp());
}

class CocktailApp extends StatelessWidget {
  const CocktailApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cocktail App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/category': (context) => const CategoryScreen(),
        '/details': (context) => const DetailScreen(),
        '/favorites': (context) => const FavoritesScreen(),
      },
    );
  }
}
