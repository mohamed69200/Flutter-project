import 'package:flutter/material.dart';

class FavoritesListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onDelete;

  const FavoritesListItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(title),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
