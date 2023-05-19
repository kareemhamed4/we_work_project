import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/modules/common/new_password/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';

class UserNewPasswordCubit extends Cubit<UserNewPasswordStates> {
  UserNewPasswordCubit() : super(UserNewPasswordInitialState());

  static UserNewPasswordCubit get(context) => BlocProvider.of(context);

  void userNewPassword({
    required String email,
    required String password,
    required String confirmPassword,
}) {
    emit(UserNewPasswordLoadingState());
    DioHelper.postData(
      url: USERNEWPASSWORD,
      baseUrl: BASEURL,
      data: {
        "email": email,
        "Password": password,
        "ConfirmPassword": confirmPassword,
      }
    ).then((value){
      final msg = value.data.toString();
      emit(UserNewPasswordSuccessState(msg));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"]["ConfirmPassword"][0];
          emit(UserNewPasswordErrorState(errorMessage));
        }else{
          emit(UserNewPasswordErrorState(error.toString()));
        }
    }else{
        emit(UserNewPasswordErrorState(error.toString()));
      }
    });
  }
}
