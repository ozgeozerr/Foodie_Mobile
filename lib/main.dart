import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'pages/welcome_1.dart';
import 'pages/welcome_2.dart';
import 'pages/welcome_3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Foodie Recipe App",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final _controller = PageController();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffefeef4),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 600,
                width: 400,
                child: PageView(
                  controller: _controller,
                  children: const [
                    Welcome1(),
                    Welcome2(),
                    Welcome3(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 30.0),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.red,
                dotColor: Colors.white,
                dotHeight: 30,
                dotWidth: 30,
                spacing: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
