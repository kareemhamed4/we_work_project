import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/user/user_get_notification_model.dart';
import 'package:we_work/modules/user/notification/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class UserNotificationCubit extends Cubit<UserNotificationStates> {
  UserNotificationCubit() : super(UserNotificationInitialState());

  static UserNotificationCubit get(context) => BlocProvider.of(context);

  List<UserNotificationModel>? userNotificationModel;
  void userGetNotification() {
    emit(UserNotificationLoadingState());
    DioHelper.getData(
      url: GETUSERNOTIFICATION,
      baseUrl: BASEURL,
      token: userToken,
    ).then((value){
      List<dynamic> responseList = value.data;
      userNotificationModel = responseList.map((json) {
        return UserNotificationModel.fromJson(json);
      }).toList();
      emit(UserNotificationSuccessState(userNotificationModel!));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          emit(UserNotificationErrorState("Unauthorized"));
        }else{
          emit(UserNotificationErrorState(error.toString()));
        }
    }else{
        emit(UserNotificationErrorState(error.toString()));
      }
    });
  }

  Future<void> userDeleteNotification({
    required int meetingId,
  }) async{
    emit(UserDeleteNotificationLoadingState());
    await DioHelper.deleteData(
      url: "$COMPANYDELETEACCEPTEDOFFER$meetingId",
      token: companyToken,
      baseUrl: BASEURL,
    ).then((value) {
      emit(UserDeleteNotificationSuccessState(value.data.toString()));
      userGetNotification();
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          final errorMessage = error.response?.data.toString();
          emit(UserDeleteNotificationErrorState(errorMessage!));
        } else {
          // Handle other DioError cases
          emit(UserDeleteNotificationErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(UserDeleteNotificationErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
