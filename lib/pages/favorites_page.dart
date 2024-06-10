import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie_mobile/pages/user_page.dart';
import '../models/recipe.dart';
import 'discover_page.dart';
import 'recipe_detail_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Recipe>> favoriteRecipes;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    favoriteRecipes = fetchFavoriteRecipes();
  }

  Future<List<Recipe>> fetchFavoriteRecipes() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return [];
    }

    DocumentReference userDocRef =
    FirebaseFirestore.instance.collection('users').doc(user.uid);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    List<Recipe> favoriteRecipes = [];

    if (userDocSnapshot.exists) {
      List<dynamic>? favorites =
      userDocSnapshot.get('favorites') as List<dynamic>?;

      if (favorites != null) {
        for (var favorite in favorites) {
          Map<String, dynamic> favoriteData =
          favorite as Map<String, dynamic>;

          favoriteRecipes.add(Recipe(
            id: favoriteData['id'] ?? '',
            image: favoriteData['image'] ?? '',
            ingredients: List<String>.from(favoriteData['ingredients'] ?? []),
            instructions:
            List<String>.from(favoriteData['instructions'] ?? []),
            name: favoriteData['name'] ?? 'Unknown',
          ));
        }
      }
    }

    return favoriteRecipes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '  My Favorites  ',
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 5,
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: favoriteRecipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorites found.'));
          }

          final favoriteRecipes = snapshot.data!;

          return ListView.builder(
            itemCount: favoriteRecipes.length,
            itemBuilder: (context, index) {
              Recipe recipe = favoriteRecipes[index];

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
                        recipe.image!.isNotEmpty
                            ? recipe.image ?? ''
                            : 'https://example.com/default_image.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          recipe.name!.isNotEmpty ? recipe.name ?? ''
                              : 'Unknown',
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
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.red.shade400,
        animationDuration: const Duration(milliseconds: 300),
        items: [
          Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:

              break;
            case 1:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DiscoverPage()));
              break;

            case 2:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UserPage()));
              break;
          }
        },
        index: _currentIndex,
      ),
    );
  }
}
