import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:foodie_mobile/models/recipe.dart';

Future<List<Recipe>> loadRecipes() async {
  try {
    final String response = await rootBundle.loadString('lib/recipe_files/recipes.json');
    final List<dynamic> data = json.decode(response);
    List<Recipe> recipes = data.map((json) => Recipe.fromJson(json)).toList();
    // Shuffle
    recipes.shuffle(Random());
    return recipes;
  } catch (e) {
    print('Error loading recipes: $e');
    return [];
  }
}
