import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/cubit/states.dart';
import 'package:we_work/models/user/user_get_profile_model.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  UserProfileModel? userProfileModel;
  Future<void> getUserWithId({
    required String userId,
  }) async {
    emit(GetUserWithIdLoadingState());
    try {
      final response = await DioHelper.getData(
        url: "$GETUSERWITHID$userId",
        baseUrl: BASEURL,
        token: userToken ?? companyToken,
      );
      userProfileModel = UserProfileModel.fromJson(response.data);
      emit(GetUserWithIdSuccessState(userProfileModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          final responseData = error.response?.data;
          final errorMessage = responseData["title"];
          emit(GetUserWithIdErrorState(errorMessage));
        } else {
          emit(GetUserWithIdErrorState(error.toString()));
        }
      } else {
        emit(GetUserWithIdErrorState(error.toString()));
      }
    }
  }

}
