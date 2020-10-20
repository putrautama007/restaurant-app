part of 'detail_restaurant_screen.dart';

class DescriptionScreen extends StatelessWidget {
  final RestaurantEntity restaurantEntity;

  DescriptionScreen({@required this.restaurantEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:16.w,right: 16.w),
      child: ListView(
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
                child: Text(restaurantEntity.rating,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: CustomColors.darkGrey,
                        fontSize: 18.sp)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Icon(
                  Icons.pin_drop,
                  color: CustomColors.grey,
                  size: 20.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(restaurantEntity.city,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: CustomColors.darkGrey,
                        fontSize: 18.sp)),
              ),
            ],
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
              restaurantEntity.description,
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
}
