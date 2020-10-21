part of 'detail_restaurant_screen.dart';

class DescriptionScreen extends StatelessWidget {
  final DetailRestaurantEntity restaurantEntity;

  DescriptionScreen({@required this.restaurantEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Text(restaurantEntity.rating,
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
                    "${restaurantEntity.address}, ${restaurantEntity.city}",
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
          Container(
            height: 20.w,
            margin: EdgeInsets.only(top: 8.w),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: restaurantEntity.categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.fromLTRB(16.w,0.w,16.w,0.w),
                    decoration: BoxDecoration(
                      color: CustomColors.yellow,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.5),
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Text(
                      restaurantEntity.categories[index].name,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: CustomColors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  );
                }),
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
