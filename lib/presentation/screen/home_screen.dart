import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/data/local/datasource/local_data_source.dart';
import 'package:restaurant_app/data/local/repository/restaurant_repository_impl.dart';
import 'package:restaurant_app/domain/router/restaurant_list_router.dart';
import 'package:restaurant_app/domain/usecase/get_list_restaurant_usecase.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';
import 'package:restaurant_app/presentation/bloc/restaurant_list_bloc/get_list_restaurant_bloc.dart';
import 'package:restaurant_app/presentation/widget/card/restaurant_card.dart';

class HomeScreen extends StatelessWidget {
  final RestaurantListRouter _restaurantListRouter = RestaurantListRouterImpl();

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
      create: (context) => GetListRestaurantBloc(
          getListRestaurantUseCase: GetListRestaurantUseCaseImpl(
              restaurantRepository: RestaurantRepositoryIml(
                  localDataSource: LocalDataSourceImpl())))
        ..add(GetListRestaurant()),
      child: Scaffold(
        backgroundColor: CustomColors.yellow,
        appBar: AppBar(
          backgroundColor: CustomColors.yellow,
          elevation: 0.0,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Restaurant",
                style: TextStyle(color: CustomColors.white, fontSize: 20.sp),
              ),
              Text(
                "Recommendation restaurant for you!",
                style: TextStyle(color: CustomColors.white, fontSize: 12.sp),
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () =>
                  _restaurantListRouter.goToSearchRestaurant(context),
              icon: Icon(
                Icons.search,
                color: CustomColors.white,
              ),
            ),
          ],
        ),
        body: BlocBuilder<GetListRestaurantBloc, GetListRestaurantState>(
          builder: (context, state) {
            if (state is GetListRestaurantLoadedState) {
              return SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(top: 16.w),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: CustomColors.lightYellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.listRestaurant.length,
                        itemBuilder: (context, index) {
                          return RestaurantCard(
                              restaurantEntity: state.listRestaurant[index]);
                        })),
              );
            } else {
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: CustomColors.lightYellow,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
