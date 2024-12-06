import 'package:flutter/material.dart';

class CocktailListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onTap;

  const CocktailListItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(title),
      onTap: onTap,
    );
  }
}
