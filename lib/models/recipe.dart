class Recipe {
  int? id;
  String? name;
  List<String>? ingredients;
  List<String>? instructions;
  String? prepTimeMinutes;
  String? cookTimeMinutes;
  String? servings;
  String? difficulty;
  String? cuisine;
  String? caloriesPerServing;
  List<String>? tags;
  String? userId;
  String? image;
  String? rating;
  String? reviewCount;
  List<String>? mealType;

  Recipe(
      {this.id,
        this.name,
        this.ingredients,
        this.instructions,
        this.prepTimeMinutes,
        this.cookTimeMinutes,
        this.servings,
        this.difficulty,
        this.cuisine,
        this.caloriesPerServing,
        this.tags,
        this.userId,
        this.image,
        this.rating,
        this.reviewCount,
        this.mealType});

  //api
  //login is not necessary
  //what i ate before, favorites, calender

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    ingredients = json['ingredients'].cast<String>();
    instructions = json['instructions'].cast<String>();
    prepTimeMinutes = json['prepTimeMinutes'].toString();
    cookTimeMinutes = json['cookTimeMinutes'].toString();
    servings = json['servings'].toString();
    difficulty = json['difficulty'].toString();
    cuisine = json['cuisine'].toString();
    caloriesPerServing = json['caloriesPerServing'].toString();
    tags = json['tags'].cast<String>();
    userId = json['userId'].toString();
    image = json['image'].toString();
    rating = json['rating'].toString();
    reviewCount = json['reviewCount'].toString();
    mealType = json['mealType'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['ingredients'] = this.ingredients;
    data['instructions'] = this.instructions;
    data['prepTimeMinutes'] = this.prepTimeMinutes;
    data['cookTimeMinutes'] = this.cookTimeMinutes;
    data['servings'] = this.servings;
    data['difficulty'] = this.difficulty;
    data['cuisine'] = this.cuisine;
    data['caloriesPerServing'] = this.caloriesPerServing;
    data['tags'] = this.tags;
    data['userId'] = this.userId;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['reviewCount'] = this.reviewCount;
    data['mealType'] = this.mealType;
    return data;
  }
}
