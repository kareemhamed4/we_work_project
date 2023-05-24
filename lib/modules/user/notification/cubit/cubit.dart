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
}
