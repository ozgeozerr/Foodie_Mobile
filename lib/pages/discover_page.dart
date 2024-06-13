import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:foodie_mobile/pages/dinner_recipes_page.dart';
import 'package:foodie_mobile/pages/snack_recipes_page.dart';
import 'package:foodie_mobile/pages/soup_recipes_page.dart';
import 'package:foodie_mobile/pages/user_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodie_mobile/models/recipe.dart';
import 'package:foodie_mobile/pages/recipe_detail_page.dart';
import 'package:foodie_mobile/pages/random_page.dart';
import 'package:foodie_mobile/pages/map_page.dart';
import '../components/recipe_service.dart';
import 'beverage_recipes_page.dart';
import 'breakfast_recipes_page.dart';
import 'dessert_recipes_page.dart';
import 'favorites_page.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  int _currentIndex = 1;
  Future<List<Recipe>>? _recipeFuture;
  List<Recipe> _recipeList = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await _loadInitialRecipes(); // Load recipes asynchronously
  }

  Future<void> _loadInitialRecipes() async {
    _recipeList = await loadRecipes();
    setState(() {
      _recipeFuture = Future.value(_recipeList);
    });
  }

  Future<void> _refreshRecipes() async {
    List<Recipe> newRecipes = await loadRecipes();
    setState(() {
      _recipeList = newRecipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: _recipeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading recipes'));
        } else {
          List<Recipe> recipeList = snapshot.data ?? [];
          List<Recipe> dinnerList = recipeList
              .where((recipe) => recipe.mealType?.contains('Dinner') ?? false)
              .toList();

          List<Recipe> soupRecipes = recipeList
              .where((recipe) => recipe.tags?.contains('Soup') ?? false)
              .toList();

          List<Recipe> dessertRecipes = recipeList
              .where((recipe) => recipe.mealType?.contains('Dessert') ?? false)
              .toList();

          List<Recipe> snackRecipes = recipeList
              .where((recipe) => recipe.mealType?.contains('Snack') ?? false)
              .toList();

          List<Recipe> breakfastRecipes = recipeList
              .where((recipe) => recipe.mealType?.contains('Breakfast') ?? false)
              .toList();

          List<Recipe> beverageRecipes = recipeList
              .where((recipe) => recipe.mealType?.contains('Beverage') ?? false)
              .toList();

          return _buildDiscoverPage(context, recipeList, dinnerList, soupRecipes,
              dessertRecipes, snackRecipes, breakfastRecipes,beverageRecipes);
        }
      },
    );
  }

  Widget _buildDiscoverPage(
      BuildContext context,
      List<Recipe> recipeList,
      List<Recipe> dinnerRecipes,
      List<Recipe> soupRecipes,
      List<Recipe> dessertRecipes,
      List<Recipe> snackRecipes,
      List<Recipe> breakfastRecipes,
      List<Recipe> beverageRecipes,
      {List<String> categories = const ['Soups', 'Main Courses', 'Snacks', 'Desserts', 'Breakfast', 'Beverages']}) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '  Foodie  ',
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
      ),
      body: RefreshIndicator(
        onRefresh: _refreshRecipes,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CarouselSlider(
                options: CarouselOptions(height: 250),
                items: _recipeList.map((recipe) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RecipeDetailPage(recipe: recipe),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade900.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  recipe.image ?? '',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  recipe.name ?? '',
                                  style: GoogleFonts.libreBaskerville(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
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
                      'Categories',
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
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    Color buttonColor;
                    switch (index) {
                      case 0:
                        buttonColor = Colors.orange.shade500;
                        break;
                      case 1:
                        buttonColor = Colors.red.shade700;
                        break;
                      case 2:
                        buttonColor = Colors.blue.shade400;
                        break;
                      case 3:
                        buttonColor = Colors.green.shade400;
                        break;
                      case 4:
                        buttonColor = Colors.purple.shade400;
                        break;
                      case 5:
                        buttonColor = Colors.orange.shade400;
                        break;
                      default:
                        buttonColor = Colors.grey; // Default color if needed
                        break;

                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          switch (index) {
                            case 0:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SoupRecipesPage(
                                        recipes: soupRecipes)),
                              );
                              break;
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DinnerRecipesPage(
                                        recipes: dinnerRecipes)),
                              );
                              break;
                            case 2:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SnackRecipesPage(
                                        recipes: snackRecipes)),
                              );
                              break;
                            case 3:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DessertRecipesPage(
                                        recipes: dessertRecipes)),
                              );
                              break;
                            case 4:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BreakfastRecipesPage(
                                        recipes: breakfastRecipes)),
                              );
                              break;

                            case 5:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BeverageRecipesPage(
                                        recipes: beverageRecipes)),
                              );
                              break;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 15),
                          backgroundColor: buttonColor,
                        ),
                        child: Text(
                          categories[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RandomPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/images/take_me_random.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/images/googlemaps.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.red.shade400,
        animationDuration: const Duration(milliseconds: 300),
        items: [
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(),
                ),
              );
              break;
            case 1:
              break;
            case 2:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UserPage()));
              break;
          }
        },
        index: _currentIndex,
      ),
    );
  }
}
