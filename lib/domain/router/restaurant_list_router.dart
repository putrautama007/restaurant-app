import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/presentation/bloc/detail_restaurant_bloc/get_detail_restaurant_bloc.dart';
import 'package:restaurant_app/presentation/screen/add_review_screen.dart';
import 'package:restaurant_app/presentation/screen/detail_restaurant_screen/detail_restaurant_screen.dart';
import 'package:restaurant_app/presentation/screen/search_restaurant_screen.dart';

abstract class RestaurantListRouter {
  goToDetailListRestaurant(context, String restaurantId);

  goToSearchRestaurant(context);

  goToAddReview(context, String restaurantId);
}

class RestaurantListRouterImpl extends RestaurantListRouter {
  @override
  goToDetailListRestaurant(context, String restaurantId) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailRestaurantScreen(restaurantId: restaurantId)));

  @override
  goToSearchRestaurant(context) =>
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SearchRestaurantScreen()));

  @override
  goToAddReview(context, String restaurantId) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AddReviewScreen(restaurantId: restaurantId))).then((value) =>
          BlocProvider.of<GetDetailRestaurantBloc>(context)
              .add(GetDetailRestaurant(restaurantId: restaurantId)));
}
