import 'package:flutter/material.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'description_screen.dart';

part 'foods_screen.dart';

part 'drinks_screen.dart';

class DetailRestaurantScreen extends StatelessWidget {
  final RestaurantEntity restaurantEntity;

  DetailRestaurantScreen({
    @required this.restaurantEntity,
  });

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200.w,
                iconTheme: IconThemeData(color: CustomColors.white),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    restaurantEntity.pictureId,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                centerTitle: false,
                title: Text(
                  restaurantEntity.name,
                  style: TextStyle(
                      color: CustomColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp),
                ),
                bottom: TabBar(
                  labelColor: CustomColors.white,
                  indicatorColor: CustomColors.lightYellow,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    Tab(
                      text: "Description",
                    ),
                    Tab(
                      text: "Foods",
                    ),
                    Tab(
                      text: "Drinks",
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              DescriptionScreen(restaurantEntity: restaurantEntity),
              FoodsScreen(
                foods: restaurantEntity.menus.foods,
              ),
              DrinksScreen(
                drinks: restaurantEntity.menus.drinks,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
