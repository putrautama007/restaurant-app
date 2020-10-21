import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/data/remote/datasource/api_constant.dart';
import 'package:restaurant_app/data/remote/datasource/remote_data_source.dart';
import 'package:restaurant_app/data/remote/repository/restaurant_repository_impl.dart';
import 'package:restaurant_app/domain/entity/detail_restaurant_entity.dart';
import 'package:restaurant_app/domain/usecase/get_restaurant_detail_usecase.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_app/presentation/bloc/detail_restaurant_bloc/get_detail_restaurant_bloc.dart';

part 'description_screen.dart';

part 'foods_screen.dart';

part 'drinks_screen.dart';

part 'reviews_screen.dart';

class DetailRestaurantScreen extends StatelessWidget {
  final String restaurantId;

  DetailRestaurantScreen({@required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
      create: (context) => GetDetailRestaurantBloc(
          getRestaurantDetailUseCase: GetRestaurantDetailUseCaseImpl(
              restaurantRepository: RestaurantRepositoryIml(
                  localDataSource: RemoteDataSourceImpl(
                      dio: Dio(BaseOptions(baseUrl: ApiConstant.baseUrl))))))
        ..add(GetDetailRestaurant(restaurantId: restaurantId)),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: BlocBuilder<GetDetailRestaurantBloc, GetDetailRestaurantState>(
              builder: (context, state) {
            if (state is GetDetailRestaurantLoadedState) {
              print(state.detailRestaurant.consumerReviews.toString());
              return NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 200.w,
                      iconTheme: IconThemeData(color: CustomColors.white),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          state.detailRestaurant.pictureId,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      centerTitle: false,
                      title: Text(
                        state.detailRestaurant.name,
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
                          Tab(
                            text: "Reviews",
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    DescriptionScreen(restaurantEntity: state.detailRestaurant),
                    FoodsScreen(
                      foods: state.detailRestaurant.menus.foods,
                    ),
                    DrinksScreen(
                      drinks: state.detailRestaurant.menus.drinks,
                    ),
                    ReviewsScreen(consumerReviews: state.detailRestaurant.consumerReviews,)
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }
}
