import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/domain/entity/detail_restaurant_entity.dart';
import 'package:restaurant_app/domain/usecase/get_restaurant_detail_usecase.dart';
import 'package:restaurant_app/presentation/bloc/detail_restaurant_bloc/get_detail_restaurant_bloc.dart';

class MockGetRestaurantDetailUseCase extends Mock
    implements GetRestaurantDetailUseCase {}

void main() {
  GetRestaurantDetailUseCase mockGetRestaurantDetailUseCase;

  setUp(() {
    mockGetRestaurantDetailUseCase = MockGetRestaurantDetailUseCase();
  });

  blocTest<GetDetailRestaurantBloc, GetDetailRestaurantState>(
    'get restaurant detail  bloc add event get detail restaurant with restaurant id'
    ' should return GetDetailRestaurantLoadingState, GetDetailRestaurantLoadedState ',
    build: () {
      DetailRestaurantEntity response = DetailRestaurantEntity(
          error: false,
          message: "message",
          address: "address",
          name: "name",
          rating: "rating",
          pictureId: "pictureId",
          menus: MenusEntity(foods: [
            FoodsEntity(
              name: 'name',
            )
          ], drinks: [
            DrinksEntity(
              name: 'name',
            )
          ]),
          categories: [
            CategoryEntity(name: "name"),
          ],
          consumerReviews: [
            ConsumerReviewEntity(name: 'name'),
          ]);
      when(mockGetRestaurantDetailUseCase.getRestaurantDetail("id"))
          .thenAnswer((_) async => response);
      return GetDetailRestaurantBloc(
          getRestaurantDetailUseCase: mockGetRestaurantDetailUseCase);
    },
    act: (bloc) => bloc.add(GetDetailRestaurant(restaurantId: 'id')),
    expect: [
      GetDetailRestaurantLoadingState(),
      GetDetailRestaurantLoadedState(
          detailRestaurant: DetailRestaurantEntity(
              error: false,
              message: "message",
              address: "address",
              name: "name",
              rating: "rating",
              pictureId: "pictureId",
              menus: MenusEntity(foods: [
                FoodsEntity(
                  name: 'name',
                )
              ], drinks: [
                DrinksEntity(
                  name: 'name',
                )
              ]),
              categories: [
            CategoryEntity(name: "name"),
          ],
              consumerReviews: [
            ConsumerReviewEntity(name: 'name'),
          ]))
    ],
  );

  blocTest<GetDetailRestaurantBloc, GetDetailRestaurantState>(
    'get restaurant detail  bloc add event get detail restaurant with restaurant id'
    ' should return GetDetailRestaurantLoadingState, GetDetailRestaurantFailedState ',
    build: () {
      DetailRestaurantEntity response = DetailRestaurantEntity(
          error: true,
          message: "message",
          address: "address",
          name: "name",
          rating: "rating",
          pictureId: "pictureId",
          menus: MenusEntity(foods: [
            FoodsEntity(
              name: 'name',
            )
          ], drinks: [
            DrinksEntity(
              name: 'name',
            )
          ]),
          categories: [
            CategoryEntity(name: "name"),
          ],
          consumerReviews: [
            ConsumerReviewEntity(name: 'name'),
          ]);
      when(mockGetRestaurantDetailUseCase.getRestaurantDetail("id"))
          .thenAnswer((_) async => response);
      return GetDetailRestaurantBloc(
          getRestaurantDetailUseCase: mockGetRestaurantDetailUseCase);
    },
    act: (bloc) => bloc.add(GetDetailRestaurant(restaurantId: 'id')),
    expect: [
      GetDetailRestaurantLoadingState(),
      GetDetailRestaurantFailedState(message: "message"),
    ],
  );
}
