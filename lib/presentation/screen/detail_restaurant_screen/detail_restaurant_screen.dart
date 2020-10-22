import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/data/local/datasource/local_data_source.dart';
import 'package:restaurant_app/data/local/model/restaurant_table.dart';
import 'package:restaurant_app/data/local/repository/local_restaurant_repository_impl.dart';
import 'package:restaurant_app/data/remote/datasource/api_constant.dart';
import 'package:restaurant_app/data/remote/datasource/remote_data_source.dart';
import 'package:restaurant_app/data/remote/repository/restaurant_repository_impl.dart';
import 'package:restaurant_app/domain/entity/detail_restaurant_entity.dart';
import 'package:restaurant_app/domain/usecase/favorite_resaturant_usecase.dart';
import 'package:restaurant_app/domain/usecase/get_restaurant_detail_usecase.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_app/external/image_strings.dart';
import 'package:restaurant_app/presentation/bloc/detail_restaurant_bloc/get_detail_restaurant_bloc.dart';
import 'package:restaurant_app/domain/router/restaurant_list_router.dart';
import 'package:restaurant_app/presentation/bloc/favorite_restaurant_bloc/favorite_restaurant_bloc.dart';
import 'package:restaurant_app/presentation/widget/button/custom_button.dart';
import 'package:restaurant_app/presentation/widget/info/custom_error_widget.dart';
import 'package:restaurant_app/presentation/widget/loading/custom_loading_progress.dart';

part 'description_screen.dart';

part 'foods_screen.dart';

part 'drinks_screen.dart';

part 'reviews_screen.dart';

class DetailRestaurantScreen extends StatefulWidget {
  final String restaurantId;
  final String restaurantName;
  final String restaurantImage;

  DetailRestaurantScreen(
      {@required this.restaurantId,
      @required this.restaurantName,
      @required this.restaurantImage});

  @override
  _DetailRestaurantScreenState createState() => _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  RestaurantTableData _restaurantTableData;

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetDetailRestaurantBloc(
            getRestaurantDetailUseCase: GetRestaurantDetailUseCaseImpl(
              restaurantRepository: RestaurantRepositoryIml(
                remoteDataSource: RemoteDataSourceImpl(
                  dio: Dio(
                    BaseOptions(
                      baseUrl: ApiConstant.baseUrl,
                    ),
                  ),
                ),
              ),
            ),
          )..add(
              GetDetailRestaurant(restaurantId: widget.restaurantId),
            ),
        ),
        BlocProvider(
          create: (context) => FavoriteRestaurantBloc(
            favoriteRestaurantUseCase: FavoriteRestaurantUseCaseImpl(
              localRestaurantRepository: LocalRestaurantRepositoryImpl(
                localDataSource: LocalDataSourceImpl(
                  appDatabase: AppDatabase(),
                ),
              ),
            ),
          )..add(GetListFavoriteRestaurantById(id: widget.restaurantId)),
        ),
      ],
      child: DefaultTabController(
        length: 4,
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
                    BlocBuilder<FavoriteRestaurantBloc,
                        FavoriteRestaurantState>(
                      builder: (context, state) {
                        if (state
                            is FavoriteRestaurantSuccessGetListByIdState) {
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
                            icon: Icon( Icons.bookmark),
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
                  bottom: TabBar(
                    isScrollable: true,
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
            body:
                BlocBuilder<GetDetailRestaurantBloc, GetDetailRestaurantState>(
                    builder: (context, state) {
              if (state is GetDetailRestaurantLoadedState) {
                _restaurantTableData = RestaurantTableData(
                  id: state.detailRestaurant.id,
                  name: state.detailRestaurant.name,
                  description: state.detailRestaurant.description,
                  pictureId: state.detailRestaurant.pictureId,
                  city: state.detailRestaurant.city,
                  address: state.detailRestaurant.address,
                  rating: state.detailRestaurant.rating,
                );
                return TabBarView(
                  children: [
                    DescriptionScreen(
                      restaurantEntity: state.detailRestaurant,
                    ),
                    FoodsScreen(
                      foods: state.detailRestaurant.menus.foods,
                    ),
                    DrinksScreen(
                      drinks: state.detailRestaurant.menus.drinks,
                    ),
                    ReviewsScreen(
                      consumerReviews: state.detailRestaurant.consumerReviews,
                      restaurantId: state.detailRestaurant.id,
                    )
                  ],
                );
              } else if (state is GetDetailRestaurantFailedState) {
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
              } else {
                return CustomLoadingProgress();
              }
            }),
          ),
        ),
      ),
    );
  }
}
