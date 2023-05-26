import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/common/user_login_model.dart';
import 'package:we_work/modules/common/login/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';

class UserLoginCubit extends Cubit<UserLoginStates> {
  UserLoginCubit() : super(UserLoginInitialState());

  static UserLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_off_outlined;

  void changeLoginSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }

  UserLoginModel? userLoginModel;
  void userLogin({
    required String email,
    required String password,
}) {
    emit(UserLoginLoadingState());
    DioHelper.postData(
      url: USERLOGIN,
      baseUrl: BASEURL,
      data: {
        "Email": email,
        "Password": password,
      }
    ).then((value){
      userLoginModel = UserLoginModel.fromJson(value.data);
      emit(UserLoginSuccessState(userLoginModel!));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          final responseData = error.response?.data;
          final errorMessage = responseData["title"];
          emit(UserLoginErrorState(errorMessage));
        }else{
          emit(UserLoginErrorState(error.toString()));
        }
    }else{
        emit(UserLoginErrorState(error.toString()));
      }
    });
  }
}
