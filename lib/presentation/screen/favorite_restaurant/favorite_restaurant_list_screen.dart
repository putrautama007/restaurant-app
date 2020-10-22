import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/data/local/datasource/local_data_source.dart';
import 'package:restaurant_app/data/local/model/restaurant_table.dart';
import 'package:restaurant_app/data/local/repository/local_restaurant_repository_impl.dart';
import 'package:restaurant_app/domain/usecase/favorite_resaturant_usecase.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_app/external/image_strings.dart';
import 'package:restaurant_app/presentation/bloc/favorite_restaurant_bloc/favorite_restaurant_bloc.dart';
import 'package:restaurant_app/presentation/widget/card/restaurant_card.dart';
import 'package:restaurant_app/presentation/widget/info/custom_error_widget.dart';
import 'package:restaurant_app/presentation/widget/loading/custom_loading_progress.dart';

class FavoriteRestaurantListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
      create: (context) => FavoriteRestaurantBloc(
        favoriteRestaurantUseCase: FavoriteRestaurantUseCaseImpl(
          localRestaurantRepository: LocalRestaurantRepositoryImpl(
            localDataSource: LocalDataSourceImpl(
              appDatabase: AppDatabase(),
            ),
          ),
        ),
      )..add(GetListFavoriteRestaurant()),
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
                "Favorite Restaurant",
                style: TextStyle(color: CustomColors.white, fontSize: 20.sp),
              ),
              Text(
                "Your favorite restaurant list!",
                style: TextStyle(color: CustomColors.white, fontSize: 12.sp),
              )
            ],
          ),
        ),
        body: BlocBuilder<FavoriteRestaurantBloc,
            FavoriteRestaurantState>(
          builder: (context, state) {
            if (state is FavoriteRestaurantSuccessGetListState) {
              if (state.listRestaurantTableData.isEmpty) {
                return Container(
                  margin: EdgeInsets.only(top: 16.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: CustomColors.lightYellow,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: CustomErrorWidget(
                    errorImage: ImageStrings.empty,
                    errorMessage: "Favorite restaurant data is empty",
                  ),
                );
              } else {
                return Container(
                  margin: EdgeInsets.only(top: 16.w),
                  height: 1.hp,
                  decoration: BoxDecoration(
                    color: CustomColors.lightYellow,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child:Container(
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
                          itemCount: state.listRestaurantTableData.length,
                          itemBuilder: (context, index) {
                            return RestaurantCard(
                                restaurantTableData: state.listRestaurantTableData[index]);
                          }),
                    ),
                  ),
                );
              }
            } else if (state is FavoriteRestaurantFailedState) {
              return Container(
                margin: EdgeInsets.only(top: 16.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: CustomColors.lightYellow,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: CustomErrorWidget(
                  errorImage: ImageStrings.error,
                  errorMessage: "An error occurred please try again later",
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.only(top: 16.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: CustomColors.lightYellow,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: CustomLoadingProgress(),
              );
            }
          },
        ),
      ),
    );
  }
}
