import 'package:flutter/material.dart';
import 'package:foodie_mobile/models/recipe.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.name ?? '',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 5,
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              //OZGE!!! WRITE A FUNCTION SO IT ADDS THIS RECIPE TO FAVORITES LIST
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to My Favorites!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              recipe.image ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Text(
              'Ingredients:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(recipe.ingredients?.join(', ') ?? ''),
            SizedBox(height: 16),
            Text(
              'Instructions:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(recipe.instructions?.join('\n') ?? ''),
          ],
        ),
      ),
    );
  }
}
