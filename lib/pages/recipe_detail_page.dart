import 'package:flutter/material.dart';
import 'package:foodie_mobile/models/recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

      setState(() {
        isFavorite = userDoc['favorites'] != null &&
            userDoc['favorites'].contains(widget.recipe.id);
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
          const SnackBar(content: Text('Removed from My Favorites.')),
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
          const SnackBar(content: Text('Added to My Favorites.')),
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
            const Text(
              'Ingredients:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(widget.recipe.ingredients?.join(', ') ?? ''),
            const SizedBox(height: 16),
            const Text(
              'Instructions:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(widget.recipe.instructions?.join('\n') ?? ''),
          ],
        ),
      ),
    );
  }
}
