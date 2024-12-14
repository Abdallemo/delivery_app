enum FoodCatagory
{
  local_Delights,
  western_Cuisine,
  chinese_Cuisine,
  indian_Cuisine,
  japanese_Cuisine,
  fast_Food,
  thia_Cuisine,
  desserts
}
class Food {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final FoodCatagory? catagory;
  List<Addon> availableAddons;

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
     this.catagory,
    required this.availableAddons,
  });

  // Converts Food object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'price': price,
      'catagory': catagory.toString().split('.').first,  // Convert enum to string
      'availableAddons': availableAddons.map((addon) => addon.toMap()).toList(),
    };
  }

  // Creates a Food object from a map
  static Food fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'],
      description: map['description'],
      imagePath: map['imagePath'],
      price: map['price'],
      catagory: FoodCatagory.values.firstWhere((e) => e.toString().split('.').first == map['catagory']),
      availableAddons: List<Addon>.from(map['availableAddons'].map((addonMap) => Addon.fromMap(addonMap))),
    );
  }
}

class Addon {
  final String name;
  final double price;

  Addon({
    required this.name,
    required this.price,
  });

  // Converts Addon object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }

  // Creates an Addon object from a map
  static Addon fromMap(Map<String, dynamic> map) {
    return Addon(
      name: map['name'],
      price: map['price'],
    );
  }
}
