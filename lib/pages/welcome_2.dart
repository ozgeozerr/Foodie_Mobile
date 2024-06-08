import 'package:flutter/material.dart';

class Welcome2 extends StatelessWidget {
  const Welcome2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/images/food.png',
                    width: 500,
                    height: 250,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Foodie is designed to help you discover, save, and cook delicious recipes from around the world.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,


                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
