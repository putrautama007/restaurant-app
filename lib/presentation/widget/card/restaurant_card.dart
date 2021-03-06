import 'package:flutter/material.dart';
import 'package:restaurant_app/data/local/model/restaurant_table.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/router/restaurant_router.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantEntity restaurantEntity;
  final RestaurantTableData restaurantTableData;
  final RestaurantRouter _restaurantListRouter = RestaurantRouterImpl();

  RestaurantCard({this.restaurantEntity, this.restaurantTableData});

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return Container(
      margin: EdgeInsets.fromLTRB(8.w, 8.w, 8.w, 0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.5),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => restaurantEntity != null
            ? _restaurantListRouter.goToDetailListRestaurant(
                restaurantEntity)
            : _restaurantListRouter.goToDetailFavoriteRestaurant(
                context,
                restaurantTableData.id,
                restaurantTableData.name,
                restaurantTableData.pictureId),
        child: Row(
          children: [
            Hero(
              tag: restaurantEntity != null
                  ? restaurantEntity.name
                  : restaurantTableData.name,
              child: Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    restaurantEntity != null
                        ? restaurantEntity.pictureId
                        : restaurantTableData.pictureId,
                    height: 90.w,
                    width: 125.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      restaurantEntity != null
                          ? restaurantEntity.name
                          : restaurantTableData.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.darkGrey,
                          fontSize: 16.sp),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pin_drop,
                            color: CustomColors.grey,
                            size: 16.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Text(
                                restaurantEntity != null
                                    ? restaurantEntity.city
                                    : restaurantTableData.city,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.darkGrey,
                                    fontSize: 14.sp)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Text(
                                restaurantEntity != null
                                    ? restaurantEntity.rating
                                    : restaurantTableData.rating,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.darkGrey,
                                    fontSize: 14.sp)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
