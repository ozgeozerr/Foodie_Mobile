import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 80),
      decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(40),
      ),

        child: const Center(
        child: Text(
          "Sign In",
           style: TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.w600,
               fontSize: 22,
           ),
         ),
       ),
      ),
    );
  }
}
