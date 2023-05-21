import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/modules/common/otp/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';

class UserVerifyOTPCubit extends Cubit<UserVerifyOTPStates> {
  UserVerifyOTPCubit() : super(UserVerifyOTPInitialState());

  static UserVerifyOTPCubit get(context) => BlocProvider.of(context);

  void userVerifyOTP({
    required String verificationCode,
    required String email,
}) {
    emit(UserVerifyOTPLoadingState());
    DioHelper.postData(
      url: "$USERVERIFYOTP$email",
      baseUrl: BASEURL,
      data: {
        "verificationcode": verificationCode,
      }
    ).then((value){
      final msg = value.data.toString();
      emit(UserVerifyOTPSuccessState(msg));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData[""][0];
          emit(UserVerifyOTPErrorState(errorMessage));
        }else{
          emit(UserVerifyOTPErrorState(error.toString()));
        }
    }else{
        emit(UserVerifyOTPErrorState(error.toString()));
      }
    });
  }
}
