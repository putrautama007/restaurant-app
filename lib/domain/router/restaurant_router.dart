import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/presentation/bloc/detail_restaurant_bloc/get_detail_restaurant_bloc.dart';
import 'package:restaurant_app/presentation/bloc/favorite_restaurant_bloc/favorite_restaurant_bloc.dart';
import 'package:restaurant_app/presentation/screen/add_review_screen.dart';
import 'package:restaurant_app/presentation/screen/detail_restaurant_screen/detail_restaurant_screen.dart';
import 'package:restaurant_app/presentation/screen/favorite_restaurant/detail_favorite_restaurant_screen.dart';
import 'package:restaurant_app/presentation/screen/search_restaurant_screen.dart';

abstract class RestaurantRouter {
  goToDetailListRestaurant(context, String restaurantId, String restaurantName,
      String restaurantImage);

  goToSearchRestaurant(context);

  goToAddReview(context, String restaurantId);

  goToDetailFavoriteRestaurant(context, String restaurantId,
      String restaurantName, String restaurantImage);
}

class RestaurantRouterImpl extends RestaurantRouter {
  @override
  goToDetailListRestaurant(context, String restaurantId, String restaurantName,
          String restaurantImage) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              DetailRestaurantScreen(
            restaurantId: restaurantId,
            restaurantImage: restaurantImage,
            restaurantName: restaurantName,
          ),
        ),
      );

  @override
  goToSearchRestaurant(context) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => SearchRestaurantScreen()));

  @override
  goToAddReview(context, String restaurantId) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              AddReviewScreen(restaurantId: restaurantId))).then((value) =>
      BlocProvider.of<GetDetailRestaurantBloc>(context)
          .add(GetDetailRestaurant(restaurantId: restaurantId)));

  @override
  goToDetailFavoriteRestaurant(context, String restaurantId,
          String restaurantName, String restaurantImage) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              DetailFavoriteRestaurantScreen(
            restaurantId: restaurantId,
            restaurantImage: restaurantImage,
            restaurantName: restaurantName,
          ),
        ),
      ).then((value) =>
          BlocProvider.of<FavoriteRestaurantBloc>(context)
              .add(GetListFavoriteRestaurant()));
}
