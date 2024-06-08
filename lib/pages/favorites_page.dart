import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:foodie_mobile/pages/user_page.dart';
import 'discover_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.red.shade400,
        animationDuration: Duration(milliseconds: 100),
        items: const [
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
            // Do nothing since you're already on FavoritesPage
              break;
            case 1:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DiscoverPage()));
              break;
            case 2:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserPage()));
              break;
            default:
              break;
          }
        },
        index: _currentIndex,
      ),
    );
  }
}
