import 'package:deliver/Models/food.dart';
import 'package:deliver/Models/resturent.dart';
import 'package:deliver/components/My_tab_bar.dart';
import 'package:deliver/components/my_drawer.dart';
import 'package:deliver/components/my_current_location.dart';
import 'package:deliver/components/my_description_box.dart';
import 'package:deliver/components/my_food_tile.dart';
import 'package:deliver/components/my_sliver_app_bar.dart';
import 'package:deliver/pages/food_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCatagory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Food> _filterMenuByCatagory(FoodCatagory catagory, List<Food> fullMenu) {
    return fullMenu.where((food) => food.catagory == catagory).toList();
  }

  //!
  List<Widget> getFoodInThisCatagory(List<Food> fullmenu) {
    return FoodCatagory.values.map((catagory) {
      List<Food> catagoryMenu = _filterMenuByCatagory(catagory, fullmenu);
      return ListView.builder(
        itemCount: catagoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 0),
        itemBuilder: (context, index) {
          final food = catagoryMenu[index];
          return MyFoodTile(
              food: food,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodPage(food: food))));
        },
      );
    }).toList();
  }

  //!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        drawer: const MyDrawer(),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  MySliverAppBar(
                      title: MyTabBar(tabController: _tabController),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Divider(
                            indent: 25,
                            endIndent: 25,
                            color: Theme.of(context).colorScheme.secondary,
                          ),

                          //location
                           MyCurrentLocation(),
                          //description box
                          const MyDescriptionBox()
                        ],
                      ))
                ],
            body: Consumer<Resturent>(
              builder: (context, resturent, child) => TabBarView(
                  controller: _tabController,
                  children: getFoodInThisCatagory(resturent.fullmenu)),
            )));
  }
}
