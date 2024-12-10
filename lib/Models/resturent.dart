import 'package:collection/collection.dart';
import 'package:deliver/Models/cart_item.dart';
import 'package:deliver/Models/food.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Resturent extends ChangeNotifier {
  final List<Food> _fullmenu = [
    //1. local dishes

    //Nasi Lemak
    Food(
        name: 'Nasi Lemak',
        description:
            "A fragrant rice dish cooked with coconut milk, served with sambal, boiled egg, fried anchovies, cucumber, and peanuts",
        imagePath: "lib/images/Local/NasiLemak.jpg",
        price: 7,
        catagory: FoodCatagory.local_Delights,
        availableAddons: [
          Addon(name: "cucumber", price: 0.1),
          Addon(name: "Extra Rice", price: 1),
          Addon(name: "Extra Egg", price: 0.3)
        ]),
    //Satay
    Food(
        name: 'Satay',
        description:
            "Skewered and grilled meat, typically served with peanut sauce, cucumber, and onion slices",
        imagePath: "lib/images/Local/SatayKajang1.jpg",
        price: 8,
        catagory: FoodCatagory.local_Delights,
        availableAddons: [
          Addon(name: "with fish and Chicken", price: 3),
          Addon(name: "Extra Stay", price: 1),
          Addon(name: "with fish", price: 2)
        ]),
    //Laksa
    Food(
        name: 'Laksa',
        description:
            "A spicy and tangy noodle soup, with variations like curry laksa or assam laksa, featuring rich flavors and fresh herbs.",
        imagePath: "lib/images/Local/laksa1.jpg",
        price: 12,
        catagory: FoodCatagory.local_Delights,
        availableAddons: [
          Addon(name: "maggi", price: 2),
          Addon(name: "Extra Laska", price: 1),
          Addon(name: "sliced Egg", price: 0.6)
        ]),
    //Roti Canai
    Food(
        name: 'Roti Canai',
        description:
            "A flaky and crispy flatbread, commonly served with dhal curry or other savory gravies.",
        imagePath: "lib/images/Local/roti_canai.jpg",
        price: 3,
        catagory: FoodCatagory.local_Delights,
        availableAddons: [
          Addon(name: "extra 2", price: 3),
          Addon(name: "Extra 4", price: 5),
          Addon(name: "Susu", price: 0.3)
        ]),
    //Mee Goreng
    Food(
        name: 'Mee Goreng',
        description:
            "Stir-fried noodles tossed with soy sauce, vegetables, egg, and optional chicken, shrimp, or tofu.",
        imagePath: "lib/images/Local/Mee_Goreng.jpg",
        price: 7,
        catagory: FoodCatagory.local_Delights,
        availableAddons: [
          Addon(name: "chicken", price: 1),
          Addon(name: "shrimp", price: 1.2),
          Addon(name: "tofu", price: 1.3)
        ]),
    //Nasi Ayam
    Food(
        name: 'Nasi Ayam',
        description:
            "A flavorful chicken rice dish, usually paired with roasted or steamed chicken, chili sauce, and fragrant rice.",
        imagePath: "lib/images/Local/Nasi_Ayam.png",
        price: 7,
        catagory: FoodCatagory.local_Delights,
        availableAddons: [
          Addon(name: "mayunize", price: 0.1),
          Addon(name: "Extra Rice", price: 1),
          Addon(name: "extra Egg", price: 0.3)
        ]),

    //2. chinees dishes
    //Dim Sum
    Food(
        name: 'Dim Sum',
        description:
            "Bite-sized dishes like dumplings, buns, and rolls, steamed or fried, perfect for sharing.",
        imagePath: "lib/images/Chinese/Dim_Sum.png",
        price: 12,
        catagory: FoodCatagory.chinese_Cuisine,
        availableAddons: [
          Addon(name: "Chili Sauce", price: 1),
          Addon(name: "Extra Dumplings", price: 5),
          Addon(name: "Jasmine Tea", price: 3)
        ]),
    //Fried Rice
    Food(
        name: 'Fried Rice',
        description:
            "Stir-fried rice with egg, vegetables, and your choice of meat, seafood, or tofu.",
        imagePath: "lib/images/Chinese/Fried_Rice.jpg",
        price: 11,
        catagory: FoodCatagory.chinese_Cuisine,
        availableAddons: [
          Addon(name: "Extra Prawns", price: 6),
          Addon(name: "Fried Egg", price: 2),
          Addon(name: "Sambal Sauce", price: 1)
        ]),
    //Wonton Noodles
    Food(
        name: 'Wonton Noodles',
        description:
            "Thin egg noodles served with wontons (dumplings), vegetables, and a savory broth or soy sauce.",
        imagePath: "lib/images/Chinese/Wonton_Noodles.jpg",
        price: 7,
        catagory: FoodCatagory.chinese_Cuisine,
        availableAddons: [
          Addon(name: "Extra Wontons", price: 4),
          Addon(name: "Char Siu (BBQ Pork)", price: 5),
          Addon(name: "Braised Egg", price: 2)
        ]),

    //3. japanese Food
    //Sushi
    Food(
        name: 'Sushi',
        description:
            "Freshly prepared rolls or nigiri with options like salmon, tuna, and avocado, served with soy sauce, wasabi, and pickled ginger",
        imagePath: "lib/images/Japanese/Sushi.jpg",
        price: 15,
        catagory: FoodCatagory.japanese_Cuisine,
        availableAddons: [
          Addon(name: "Extra Wasabi", price: 1),
          Addon(name: "Additional Sushi Roll", price: 6),
          Addon(name: "Miso Soup", price: 4)
        ]),
    //Ramen
    Food(
        name: 'Ramen',
        description:
            "Hearty noodle soup with a rich broth, tender meat, seaweed, and a soft-boiled egg.",
        imagePath: "lib/images/Japanese/Ramen_12.jpg",
        price: 18,
        catagory: FoodCatagory.japanese_Cuisine,
        availableAddons: [
          Addon(name: "Extra Egg", price: 3),
          Addon(name: "Additional Noodles ", price: 5),
          Addon(name: "Spicy Chili Oi", price: 2)
        ]),
    //Teriyaki
    Food(
        name: 'Teriyaki',
        description:
            "Grilled meat or fish glazed with a sweet and savory teriyaki sauce, served with steamed rice and vegetables.",
        imagePath: "lib/images/Japanese/chicken-teriyaki.jpg",
        price: 20,
        catagory: FoodCatagory.japanese_Cuisine,
        availableAddons: [
          Addon(name: "Extra Teriyaki Sauce", price: 2),
          Addon(name: "Side of Pickled Vegetables", price: 3),
          Addon(name: "Miso Soup", price: 4)
        ]),

    //4. indian dishes

    //Biryani
    Food(
        name: 'Biryani',
        description:
            "A flavorful rice dish cooked with aromatic spices and your choice of meat (chicken, mutton, or beef), often served with raita or curry.",
        imagePath: "lib/images/Indian/biryan.jpg",
        price: 15,
        catagory: FoodCatagory.indian_Cuisine,
        availableAddons: [
          Addon(name: "Extra Raita", price: 3),
          Addon(name: "Additional Meat", price: 4),
          Addon(name: "Boiled Egg", price: 2)
        ]),
    //Tandoori Chicken
    Food(
        name: 'Tandoori Chicken',
        description:
            "A flavorful rice dish cooked with aromatic spices and your choice of meat (chicken, mutton, or beef), often served with raita or curry.",
        imagePath: "lib/images/Indian/tandoor_chicken.jpg",
        price: 20,
        catagory: FoodCatagory.indian_Cuisine,
        availableAddons: [
          Addon(name: "Extra Tandoori Sauce", price: 2),
          Addon(name: "Side of Naan", price: 4),
          Addon(name: "Sliced Onion Salad", price: 3)
        ]),
    //Masala Dishes
    Food(
        name: 'Masala Dishes',
        description:
            "Marinated chicken cooked in a traditional clay oven, giving it a smoky flavor and crispy texture, usually served with naan or rice.",
        imagePath: "lib/images/Indian/chicken_tikka_masala.jpg",
        price: 20,
        catagory: FoodCatagory.indian_Cuisine,
        availableAddons: [
          Addon(name: "Extra Tandoori Sauce", price: 2),
          Addon(name: "Side of Naan", price: 4),
          Addon(name: "Sliced Onion Salad", price: 3)
        ]),
    //Chapati
    Food(
        name: 'Chapati',
        description:
            "A soft, round flatbread made from whole wheat flour, often served with curries and masala dishes.",
        imagePath: "lib/images/Indian/maxresdefault.jpg",
        price: 5,
        catagory: FoodCatagory.indian_Cuisine,
        availableAddons: [
          Addon(name: "Extra Chapati", price: 5),
          Addon(name: "Side of Curry", price: 4),
          Addon(name: "Ghee Butter", price: 3)
        ]),

    //5. Western dishes

    //Burgers
    Food(
        name: 'Burgers',
        description:
            "A juicy beef or chicken patty served in a soft bun with lettuce, tomato, cheese, and your choice of sauce.",
        imagePath: "lib/images/Western/Burger.jpg",
        price: 15,
        catagory: FoodCatagory.western_Cuisine,
        availableAddons: [
          Addon(name: "Extra Cheese", price: 2),
          Addon(name: "Bacon Strips", price: 3),
          Addon(name: "Fries ", price: 4)
        ]),
    //Pizza
    Food(
        name: 'Pizza',
        description:
            "A classic pizza with a crispy crust, topped with mozzarella cheese, tomato sauce, and your choice of meat, veggies, or seafood.",
        imagePath: "lib/images/Western/Pizza.jpg",
        price: 20,
        catagory: FoodCatagory.western_Cuisine,
        availableAddons: [
          Addon(name: "Extra Toppings", price: 3),
          Addon(name: "Extra Cheese", price: 2),
          Addon(name: "Garlic Bread", price: 6)
        ]),

    //6. Thia Dishes

    //Tom Yum
    Food(
        name: 'Tom Yum',
        description:
            "A hot and sour soup with a flavorful blend of lemongrass, kaffir lime leaves, galangal, chili, and shrimp or chicken.",
        imagePath: "lib/images/Thai/Tom_Yum_Soup.jpg",
        price: 16,
        catagory: FoodCatagory.thia_Cuisine,
        availableAddons: [
          Addon(name: "Extra Shrimp", price: 5),
          Addon(name: "Extra Chili", price: 1),
          Addon(name: "Rice ", price: 3)
        ]),
    //Pad Thai
    Food(
        name: 'Pad Thai',
        description:
            "Stir-fried rice noodles with eggs, tofu, shrimp or chicken, bean sprouts, peanuts, and a tangy tamarind sauce.",
        imagePath: "lib/images/Thai/Pad_Thai.jpg",
        price: 20,
        catagory: FoodCatagory.thia_Cuisine,
        availableAddons: [
          Addon(name: "Extra Tofu", price: 4),
          Addon(name: "Extra Shrimp", price: 5),
          Addon(name: "Lime", price: 1)
        ]),
    //Green Curry
    Food(
        name: 'Green Curry',
        description:
            "A rich, spicy curry made with green curry paste, coconut milk, chicken or beef, and vegetables like eggplant and bamboo shoots.",
        imagePath: "lib/images/Thai/Thai_green_curry-2.jpg",
        price: 21,
        catagory: FoodCatagory.thia_Cuisine,
        availableAddons: [
          Addon(name: "Extra Chicken", price: 5),
          Addon(name: "Steamed Rice", price: 3),
          Addon(name: "Extra Coconut Milk", price: 2)
        ]),
    //Mango Sticky Rice
    Food(
        name: 'Mango Sticky Rice',
        description:
            "A sweet dessert made with sticky rice, fresh mango slices, and a drizzle of coconut milk.",
        imagePath: "lib/images/Thai/rice_with_mango.jpg",
        price: 12,
        catagory: FoodCatagory.thia_Cuisine,
        availableAddons: [
          Addon(name: "Extra Mango ", price: 4),
          Addon(name: "Extra Coconut Milk ", price: 2),
          Addon(name: "Sesame Seeds", price: 1)
        ]),

    //7. Snacks & Street Food

    //Pisang Goreng
    Food(
        name: 'Pisang Goreng',
        description:
            "Crispy deep-fried bananas coated in a light batter, a popular snack that’s sweet and crunchy.",
        imagePath: "lib/images/Snacks_Street/PisangGoreng.jpg",
        price: 6,
        catagory: FoodCatagory.fast_Food,
        availableAddons: [
          Addon(name: "Extra Banan", price: 2),
          Addon(name: "Honey Drizzle ", price: 1),
          Addon(name: "Ice Cream", price: 4)
        ]),
    //Popiah
    Food(
        name: 'Popiah ',
        description:
            "Fresh spring rolls filled with vegetables, eggs, and meat, wrapped in a thin, soft skin, served with a savory sauce.",
        imagePath: "lib/images/Snacks_Street/Popiah.jpg",
        price: 7,
        catagory: FoodCatagory.fast_Food,
        availableAddons: [
          Addon(name: "Extra Filling", price: 3),
          Addon(name: "Extra Sauce", price: 2),
          Addon(name: "Fried Spring Roll", price: 4)
        ]),
    //Keropok Lekor
    Food(
        name: 'Keropok Lekor ',
        description:
            "A crispy fish cracker, deep-fried and often served with a spicy dipping sauce.",
        imagePath: "lib/images/Snacks_Street/Keropok_Lekor.png",
        price: 7,
        catagory: FoodCatagory.fast_Food,
        availableAddons: [
          Addon(name: "Extra Sauce", price: 2),
          Addon(name: "Extra Keropok", price: 4),
          Addon(name: "Lime ", price: 1)
        ]),
    //Satay
    Food(
        name: 'Satay',
        description:
            "Grilled skewers of marinated meat (usually chicken or beef), served with a rich peanut sauce and a side of rice cakes.",
        imagePath: "lib/images/Snacks_Street/chicken_satay.jpg",
        price: 9,
        catagory: FoodCatagory.fast_Food,
        availableAddons: [
          Addon(name: "Extra Skewers", price: 4),
          Addon(name: "Extra Peanut Sauce", price: 2),
          Addon(name: "Cucumber ", price: 1)
        ]),

    //8. Deserts

    //Ice Cream
    Food(
        name: 'Ice Cream',
        description:
            "Creamy and delicious ice cream available in a variety of flavors, perfect for a sweet treat.",
        imagePath: "lib/images/Desserts/ice_cream.jpg",
        price: 8,
        catagory: FoodCatagory.desserts,
        availableAddons: [
          Addon(name: "Extra Toppings", price: 2),
          Addon(name: "Chocolate Sauce", price: 2),
          Addon(name: "Waffle Cone", price: 3)
        ]),
    //Cakes
    Food(
        name: 'Cake',
        description:
            "A selection of moist, freshly baked cakes in flavors like chocolate, vanilla, and pandan, topped with creamy frosting.",
        imagePath: "lib/images/Desserts/cake.jpg",
        price: 12,
        catagory: FoodCatagory.desserts,
        availableAddons: [
          Addon(name: "Extra Slice", price: 5),
          Addon(name: "Whipped Cream", price: 3),
          Addon(name: "Fruit Toppings", price: 4)
        ]),
    //Kuih-Muih (Traditional Snacks)
    Food(
        name: 'Kuih-Muih',
        description:
            "A variety of traditional Malay sweet snacks, such as onde-onde, kuih lapis, and kuih ketayap, often made with coconut or palm sugar.",
        imagePath: "lib/images/Desserts/Kuih_Muih.jpg",
        price: 6,
        catagory: FoodCatagory.desserts,
        availableAddons: [
          Addon(name: "Extra Kuih", price: 3),
          Addon(name: "Coconut Shavings", price: 2),
          Addon(name: "EPalm Sugar Drizzlegg", price: 2)
        ]),
  ];

  List<Food> get fullmenu => _fullmenu;

  final List<CartItem> _cart = [];
  String _deliveryAddress = 'jalan 10';
  
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  //delivery address


  //OP
  void addToCart(Food food, List<Addon> selectedAddons) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;

      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddons;
    });
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
    }
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;
      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }

    return total;
  }

  //total item Count;
  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  //clearing cart code

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }


//update delivery Location

  void updatedDeliveryAddres(String newAddress){
    _deliveryAddress = newAddress;
    notifyListeners();
  }

//report Generator

  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here is Your receipt.");
    receipt.writeln();

    //fomtd dte

    String formatedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formatedDate);
    receipt.writeln("----------");
    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} X ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt
            .writeln("   Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();

    }
    receipt.writeln("----------");
      receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln("Delivering to: $deliveryAddress");


    return receipt.toString();

    
  }

  String _formatPrice(double pirce) {
    return "RM ${pirce.toStringAsFixed(2)}";
  }

  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }
}
