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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _buildPageRoute(const HomeScreen(), settings);
          case '/category':
            return _buildPageRoute(const CategoryScreen(), settings);
          case '/details':
            return _buildPageRoute(const DetailScreen(), settings);
          case '/favorites':
            return _buildPageRoute(const FavoritesScreen(), settings);
          default:
            return MaterialPageRoute(builder: (context) => const HomeScreen());
        }
      },
    );
  }

  PageRouteBuilder _buildPageRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
