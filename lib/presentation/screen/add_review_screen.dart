import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/data/remote/datasource/api_constant.dart';
import 'package:restaurant_app/data/remote/datasource/remote_data_source.dart';
import 'package:restaurant_app/data/remote/repository/restaurant_repository_impl.dart';
import 'package:restaurant_app/domain/usecase/add_review_usecase.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_app/presentation/bloc/add_review/add_review_bloc.dart';
import 'package:restaurant_app/presentation/widget/button/custom_button.dart';
import 'package:restaurant_app/presentation/widget/text_field/custom_text_field.dart';

class AddReviewScreen extends StatelessWidget {
  final String restaurantId;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final FocusNode _reviewFocusNode = FocusNode();

  AddReviewScreen({@required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
      create: (context) => AddReviewBloc(
          addReviewUseCase: AddReviewUseCaseImpl(
              restaurantRepository: RestaurantRepositoryIml(
                  remoteDataSource: RemoteDataSourceImpl(
                      dio: Dio(BaseOptions(baseUrl: ApiConstant.baseUrl)))))),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.yellow,
          iconTheme: IconThemeData(color: CustomColors.white),
          title: Text(
            "Add Review",
            style: TextStyle(
                color: CustomColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
        ),
        body: BlocListener<AddReviewBloc, AddReviewState>(
          listener: (context, state) {
            if (state is AddReviewSuccessState) {
              Navigator.pop(context);
            } else if (state is AddReviewFailedState) {
              errorMessage(context, "An error occurred please try again later");
            } else if (state is AddReviewNameEmptyState) {
              errorMessage(context, "Name cannot be empty");
            } else if (state is AddReviewReviewEmptyState) {
              errorMessage(context, "Review cannot be empty");
            }
          },
          child: ListView(
            children: [
              CustomTextField(
                  controller: _userNameController,
                  hint: "Your name",
                  onFieldSubmitted: (v) =>
                      FocusScope.of(context).requestFocus(_reviewFocusNode),
                  keyboardType: TextInputType.name),
              CustomTextField(
                controller: _reviewController,
                hint: "Your review",
                keyboardType: TextInputType.multiline,
                maxLines: null,
                focusNode: _reviewFocusNode,
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: BlocBuilder<AddReviewBloc, AddReviewState>(
                    builder: (context, state) {
                  if (state is AddReviewLoadingState) {
                    return Stack(
                      children: [
                        CustomButton(
                          borderRadius: 10.0,
                          text: "Add Review",
                          onTap: () => {},
                        ),
                        Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                CustomColors.darkGrey),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return CustomButton(
                      borderRadius: 10.0,
                      text: "Add Review",
                      onTap: () => BlocProvider.of<AddReviewBloc>(context).add(
                          AddReview(
                              restaurantId: restaurantId,
                              userName: _userNameController.text,
                              review: _reviewController.text)),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void errorMessage(context, String message) {
    final _snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: CustomColors.yellow,
      content: Text(message, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp),),
    );
    Scaffold.of(context).showSnackBar(_snackBar);
  }
}
