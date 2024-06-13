import 'package:flutter/material.dart';
import 'user_page.dart';  // Import the UserPage here

class AboutFoodiePage extends StatelessWidget {
  const AboutFoodiePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '  About Foodie  ',
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const UserPage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Image.asset(
                    "lib/images/help.png"
                ),

                _buildListItem(Icons.play_arrow_sharp, 'Foodie is an app to help you discover delicious recipes from all around the world.'),
                _buildListItem(Icons.play_arrow_sharp, 'After creating an account, or logging in, you will be able to access our high-quality recipes.'),
                _buildListItem(Icons.play_arrow_sharp, 'In the Discover page, you can see the recipes we provide on a slider or choose from different categories.'),
                _buildListItem(Icons.play_arrow_sharp, 'Clicking on the random button will surprise you with a random meal!'),
                _buildListItem(Icons.play_arrow_sharp, 'Foodie will show you the map around your location to find the nearest grocery store for your ingredients.'),
                _buildListItem(Icons.play_arrow_sharp, 'If you like a recipe or want to try it later, you can add it to your favorites list and access it anytime!'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
