import 'dart:math';
import 'package:flutter/material.dart';
import 'package:foodie_mobile/models/recipe.dart';
import 'package:foodie_mobile/components/recipe_service.dart';
import 'package:google_fonts/google_fonts.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Foodie',
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 5,
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: loadRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes available!'));
          } else {
            List<Recipe> recipes = snapshot.data!;
            Recipe randomRecipe = recipes[Random().nextInt(recipes.length)];
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Text(
                      "Here is your recipe of the day, enjoy!",
                      style: GoogleFonts.libreBaskerville(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  Image.network(
                    randomRecipe.image ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ingredients:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(randomRecipe.ingredients?.join(', ') ?? ''),
                        const SizedBox(height: 16),
                        const Text(
                          'Instructions:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(randomRecipe.instructions?.join('\n') ?? ''),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
