import 'package:moor_flutter/moor_flutter.dart';

part 'restaurant_table.g.dart';

class RestaurantTable extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get description => text()();

  TextColumn get pictureId => text()();

  TextColumn get city => text()();

  TextColumn get address => text()();

  TextColumn get rating => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [RestaurantTable],daos: [RestaurantDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));

  int get schemaVersion => 1;
}

@UseDao(tables: [RestaurantTable])
class RestaurantDao extends DatabaseAccessor<AppDatabase> with _$RestaurantDaoMixin {
  RestaurantDao(AppDatabase db) : super(db);
  Future<List<RestaurantTableData>> getFavoriteRestaurantList() =>
      select(restaurantTable).get();

  Future<RestaurantTableData> getFavoriteRestaurantById(String id) =>
      (select(restaurantTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future insertFavoriteRestaurant(RestaurantTableData restaurantTableData) =>
      into(restaurantTable).insert(restaurantTableData);

  Future deleteFavoriteRestaurant(RestaurantTableData restaurantTableData) =>
      delete(restaurantTable).delete(restaurantTableData);
}

