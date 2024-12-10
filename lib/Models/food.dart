
class Food {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final FoodCatagory catagory;
  List<Addon> availableAddons;

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.catagory,
    required this.availableAddons
  }
  );


}
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

class Addon{
  String name;
  double price;

  Addon({
    required this.name,
    required this.price
  });
}
