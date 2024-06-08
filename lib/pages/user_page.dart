import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'discover_page.dart';
import 'favorites_page.dart';
import 'user_settings_page.dart';
import 'shopping_list_page.dart';
import 'about_foodie_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserSettingsPage()),
                );
              },
              child: const Text('User Settings'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShoppingListPage()),
                );
              },
              child: const Text('My Shopping List'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutFoodiePage()),
                );
              },
              child: const Text('About Foodie'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.red.shade400,
        animationDuration: const Duration(milliseconds: 100),
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
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          Icon(
            Icons.info,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FavoritesPage()));
              break;
            case 1:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DiscoverPage()));
              break;
            case 2:
            // Do nothing since you're already on UserPage
              break;
            case 3:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShoppingListPage()));
              break;
            case 4:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AboutFoodiePage()));
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
