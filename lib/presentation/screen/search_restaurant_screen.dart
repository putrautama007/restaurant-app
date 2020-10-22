import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/data/remote/datasource/api_constant.dart';
import 'package:restaurant_app/data/remote/datasource/remote_data_source.dart';
import 'package:restaurant_app/data/remote/repository/restaurant_repository_impl.dart';
import 'package:restaurant_app/domain/usecase/serch_restaurant_usecase.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';
import 'package:restaurant_app/external/image_strings.dart';
import 'package:restaurant_app/presentation/bloc/search_restaurant_bloc/search_restaurant_bloc.dart';
import 'package:restaurant_app/presentation/widget/card/restaurant_card.dart';
import 'package:restaurant_app/presentation/widget/info/custom_error_widget.dart';
import 'package:restaurant_app/presentation/widget/loading/custom_loading_progress.dart';

class SearchRestaurantScreen extends StatefulWidget {
  @override
  _SearchRestaurantScreenState createState() => _SearchRestaurantScreenState();
}

class _SearchRestaurantScreenState extends State<SearchRestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
        create: (context) => SearchRestaurantBloc(
              searchRestaurantUseCase: SearchRestaurantUseCaseImpl(
                restaurantRepository: RestaurantRepositoryIml(
                  remoteDataSource: RemoteDataSourceImpl(
                    dio: Dio(
                      BaseOptions(baseUrl: ApiConstant.baseUrl),
                    ),
                  ),
                ),
              ),
            )..add(
                SearchRestaurant(searchText: ""),
              ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColors.yellow,
            elevation: 0.0,
            iconTheme: IconThemeData(color: CustomColors.white),
            title: BlocBuilder<SearchRestaurantBloc, SearchRestaurantState>(
                builder: (context, state) {
              return Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        color: CustomColors.darkGrey,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 20.w,
                        child: TextFormField(
                          autofocus: true,
                          maxLines: 1,
                          style: TextStyle(color: CustomColors.darkGrey),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(8.w, 15.w, 8.w, 5.w),
                              border: InputBorder.none,
                              hintText: "Cari restaurant",
                              hintStyle: TextStyle(color: CustomColors.grey)),
                          onChanged: (value) {
                            BlocProvider.of<SearchRestaurantBloc>(context).add(
                                SearchRestaurant(searchText: value.toString()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: CustomColors.white,
                ),
              );
            }),
          ),
          body: BlocBuilder<SearchRestaurantBloc, SearchRestaurantState>(
            builder: (context, state) {
              if (state is SearchRestaurantLoadedState) {
                if (state.listRestaurant.isEmpty) {
                  return CustomErrorWidget(
                    errorImage: ImageStrings.empty,
                    errorMessage: "Restaurant not found",
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0.w),
                    decoration: BoxDecoration(
                      color: CustomColors.lightYellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.listRestaurant.length,
                      itemBuilder: (context, index) {
                        return RestaurantCard(
                            restaurantEntity: state.listRestaurant[index]);
                      },
                    ),
                  );
                }
              } else if (state is SearchRestaurantFailedState) {
                return CustomErrorWidget(
                  errorImage: ImageStrings.error,
                  errorMessage: "An error occurred please try again later",
                );
              } else {
                return CustomLoadingProgress();
              }
            },
          ),
        ));
  }
}
