import 'package:flutter/material.dart';
import 'package:foodie_mobile/models/recipe.dart';
import 'package:foodie_mobile/pages/recipe_detail_page.dart';

class BeverageRecipesPage extends StatelessWidget {
  final List<Recipe> recipes;

  const BeverageRecipesPage({Key? key, required this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Recipe> beverageRecipes = recipes.where((recipe) => recipe.mealType?.contains('Beverage') ?? false).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Beverage Recipes',
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
          ),
        ),

        backgroundColor: Colors.red,
        elevation: 5,
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
      ),
      body: ListView.builder(
        itemCount: beverageRecipes.length,
        itemBuilder: (context, index) {
          Recipe recipe = beverageRecipes[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailPage(recipe: recipe),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              width: double.infinity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.network(
                    recipe.image ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      recipe.name ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
