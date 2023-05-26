import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/modules/common/new_password/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';

class UserNewPasswordCubit extends Cubit<UserNewPasswordStates> {
  UserNewPasswordCubit() : super(UserNewPasswordInitialState());

  static UserNewPasswordCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  bool isConfirmPassword = true;
  IconData suffixIcon = Icons.visibility_off_outlined;
  IconData suffixConfirmIcon = Icons.visibility_off_outlined;

  void changePasswordSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordSuffixState());
  }

  void changeConfirmPasswordSuffixIcon() {
    isConfirmPassword = !isConfirmPassword;
    suffixConfirmIcon =
    isConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeConfirmPasswordSuffixState());
  }

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
