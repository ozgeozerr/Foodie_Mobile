import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie_mobile/pages/discover_page.dart';
import 'package:foodie_mobile/pages/welcome_1.dart';
import 'package:foodie_mobile/pages/welcome_2.dart';
import 'package:foodie_mobile/pages/welcome_3.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = PageController();

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        log(user.toString());

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DiscoverPage()),
        );
      }
    });
  }

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
                  children:  [
                    Welcome1(),
                    Welcome2(),
                    Welcome3(ctrl: _controller,),
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
