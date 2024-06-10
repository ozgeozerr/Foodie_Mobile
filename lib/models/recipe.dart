class Recipe {
  String? id;
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

  Recipe({
    this.id,
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
    this.mealType,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      prepTimeMinutes: json['prepTimeMinutes']?.toString(),
      cookTimeMinutes: json['cookTimeMinutes']?.toString(),
      servings: json['servings']?.toString(),
      difficulty: json['difficulty']?.toString(),
      cuisine: json['cuisine']?.toString(),
      caloriesPerServing: json['caloriesPerServing']?.toString(),
      tags: List<String>.from(json['tags'] ?? []),
      userId: json['userId']?.toString(),
      image: json['image']?.toString(),
      rating: json['rating']?.toString(),
      reviewCount: json['reviewCount']?.toString(),
      mealType: List<String>.from(json['mealType'] ?? []),
    );
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id']?.toString(),
      name: map['name']?.toString(),
      ingredients: List<String>.from(map['ingredients'] ?? []),
      instructions: List<String>.from(map['instructions'] ?? []),
      prepTimeMinutes: map['prepTimeMinutes']?.toString(),
      cookTimeMinutes: map['cookTimeMinutes']?.toString(),
      servings: map['servings']?.toString(),
      difficulty: map['difficulty']?.toString(),
      cuisine: map['cuisine']?.toString(),
      caloriesPerServing: map['caloriesPerServing']?.toString(),
      tags: List<String>.from(map['tags'] ?? []),
      userId: map['userId']?.toString(),
      image: map['image']?.toString(),
      rating: map['rating']?.toString(),
      reviewCount: map['reviewCount']?.toString(),
      mealType: List<String>.from(map['mealType'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'servings': servings,
      'difficulty': difficulty,
      'cuisine': cuisine,
      'caloriesPerServing': caloriesPerServing,
      'tags': tags,
      'userId': userId,
      'image': image,
      'rating': rating,
      'reviewCount': reviewCount,
      'mealType': mealType,
    };
    return data;
  }
}
