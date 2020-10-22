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
import 'package:restaurant_app/presentation/widget/info/custom_error_widget.dart';
import 'package:restaurant_app/presentation/widget/loading/custom_loading_progress.dart';

class DetailFavoriteRestaurantScreen extends StatefulWidget {
  final String restaurantId;
  final String restaurantName;
  final String restaurantImage;

  DetailFavoriteRestaurantScreen({
    @required this.restaurantId,
    @required this.restaurantName,
    @required this.restaurantImage,
  });

  @override
  _DetailFavoriteRestaurantScreenState createState() =>
      _DetailFavoriteRestaurantScreenState();
}

class _DetailFavoriteRestaurantScreenState
    extends State<DetailFavoriteRestaurantScreen> {
  RestaurantTableData _restaurantTableData;

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
      )..add(GetListFavoriteRestaurantById(id: widget.restaurantId)),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                backgroundColor: CustomColors.yellow,
                pinned: true,
                expandedHeight: 200.w,
                iconTheme: IconThemeData(color: CustomColors.white),
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: widget.restaurantName,
                    child: Material(
                      color: Colors.transparent,
                      child: Image.network(
                        widget.restaurantImage,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                centerTitle: false,
                title: Text(
                  widget.restaurantName,
                  style: TextStyle(
                      color: CustomColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp),
                ),
                actions: [
                  BlocBuilder<FavoriteRestaurantBloc, FavoriteRestaurantState>(
                    builder: (context, state) {
                      if (state is FavoriteRestaurantSuccessGetListByIdState) {
                        _restaurantTableData = state.restaurantTableData;
                        return IconButton(
                          icon: Icon(Icons.bookmark),
                          onPressed: () =>
                              BlocProvider.of<FavoriteRestaurantBloc>(context)
                                  .add(
                            DeleteFavoriteRestaurant(
                                restaurantTableData: _restaurantTableData),
                          ),
                        );
                      } else if (state
                          is FavoriteRestaurantSuccessInsertState) {
                        return IconButton(
                          icon: Icon(Icons.bookmark),
                          onPressed: () =>
                              BlocProvider.of<FavoriteRestaurantBloc>(context)
                                  .add(
                            DeleteFavoriteRestaurant(
                                restaurantTableData: _restaurantTableData),
                          ),
                        );
                      } else {
                        return IconButton(
                          icon: Icon(Icons.bookmark_border),
                          onPressed: () =>
                              BlocProvider.of<FavoriteRestaurantBloc>(context)
                                  .add(
                            InsertFavoriteRestaurant(
                                restaurantTableData: _restaurantTableData),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ];
          },
          body: BlocBuilder<FavoriteRestaurantBloc, FavoriteRestaurantState>(
              builder: (context, state) {
            if (state is FavoriteRestaurantSuccessGetListByIdState) {
              return _buildDetailBody(state.restaurantTableData);
            } else if (state is FavoriteRestaurantFailedState) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: CustomColors.yellow,
                  iconTheme: IconThemeData(color: CustomColors.white),
                ),
                body: CustomErrorWidget(
                  errorImage: ImageStrings.error,
                  errorMessage: "An error occurred please try again later",
                ),
              );
            } else if (_restaurantTableData != null) {
              return _buildDetailBody(_restaurantTableData);
            } else {
              return CustomLoadingProgress();
            }
          }),
        ),
      ),
    );
  }

  Widget _buildDetailBody(RestaurantTableData restaurantTableData) => Container(
        color: CustomColors.lightYellow,
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(restaurantTableData.rating,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: CustomColors.darkGrey,
                          fontSize: 18.sp)),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.pin_drop,
                  color: CustomColors.grey,
                  size: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(
                      "${restaurantTableData.address}, ${restaurantTableData.city}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: CustomColors.darkGrey,
                          fontSize: 16.sp)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.w),
              child: Text(
                "Category",
                style: TextStyle(
                    color: CustomColors.yellow,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.w),
              child: Text(
                "Description",
                style: TextStyle(
                    color: CustomColors.yellow,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.w),
              child: Text(
                restaurantTableData.description,
                style: TextStyle(
                    color: CustomColors.darkGrey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      );
}
