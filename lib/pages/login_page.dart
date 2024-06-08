import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie_mobile/components/my_button_signin.dart';
import 'package:foodie_mobile/components/my_textfield.dart';
import 'package:foodie_mobile/pages/discover_page.dart';

import '../models/recipe.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});


  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> signUserIn() async {

      String data = await rootBundle.loadString('lib/recipe_files/recipes.json');
      final List<dynamic> jsonResult = json.decode(data);


      List<Recipe> recipeList = jsonResult.map((element) => Recipe.fromJson(element)).toList();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DiscoverPage()),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffefeef4),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 70),
              const Stack(
                children: [
                  Icon(
                    Icons.lock,
                    size: 150,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Text(
                'Welcome to Foodie!',
                style: TextStyle(
                  color: Colors.brown.shade900,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              //username textfield
              MyTextField(
                controller: userNameController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              //password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Text(
                "Don't have an account? Register now!",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 20),
              //sign in button
              MyButton(
                onTap: signUserIn,
              ),
              const SizedBox(height: 20),
              const Text(
                'or continue with',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //login with google button
                  Image.asset(
                    'lib/images/google.png',
                    height: 70,
                    width: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
