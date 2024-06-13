import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodie_mobile/models/recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  bool isFavorite = false;

  Future<void> checkFavoriteStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      log(userDoc['favorites'].length.toString());
      setState(() {
        isFavorite = userDoc['favorites']
                ?.map((e) => e["id"] == widget.recipe.id.toString())
                .contains(true) ??
            false;
      });
    }
  }

  Future<void> addToFavorites(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      if (isFavorite) {
        await userDocRef.update({
          'favorites': FieldValue.arrayRemove([
            {
              'id': widget.recipe.id,
              'image': widget.recipe.image,
              'ingredients': widget.recipe.ingredients,
              'instructions': widget.recipe.instructions,
              'name': widget.recipe.name,
            }
          ]),
        });

        setState(() {
          isFavorite = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Removed from My Favorites.'),
              duration: Duration(milliseconds: 350)),
        );
      } else {
        await userDocRef.update({
          'favorites': FieldValue.arrayUnion([
            {
              'id': widget.recipe.id,
              'image': widget.recipe.image,
              'ingredients': widget.recipe.ingredients,
              'instructions': widget.recipe.instructions,
              'name': widget.recipe.name,
            }
          ]),
        });

        setState(() {
          isFavorite = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to My Favorites.'),
            duration: Duration(milliseconds: 350),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipe.name ?? '',
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
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () => addToFavorites(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.recipe.image ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 8),
            Text(
              widget.recipe.name ?? '',
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green.shade400.withOpacity(0.8),
                ),
                child: Center(
                  child: Text(
                    'Ingredients',
                    style: GoogleFonts.libreBaskerville(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              (widget.recipe.ingredients
                      ?.map((ingredients) => '• ${ingredients.trim()}')
                      .join('\n') ??
                  ''),
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red.shade400.withOpacity(0.8),
                ),
                child: Center(
                  child: Text(
                    'Instructions',
                    style: GoogleFonts.libreBaskerville(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              (widget.recipe.instructions
                      ?.map((instruction) => '• ${instruction.trim()}')
                      .join('\n') ??
                  ''),
              style: const TextStyle(fontSize: 16.0),
            )
          ],
        ),
      ),
    );
  }
}
