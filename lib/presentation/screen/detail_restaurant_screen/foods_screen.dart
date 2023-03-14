part of 'detail_restaurant_screen.dart';

class FoodsScreen extends StatelessWidget {
  final List<FoodsEntity> foods;

  FoodsScreen({required this.foods});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.lightYellow,
      child: ListView.builder(
          itemCount: foods.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 16.w),
              child: Text(foods[index].name,style: TextStyle(fontSize: 20.sp,color: CustomColors.darkGrey),),
            );
          }),
    );
  }
}
