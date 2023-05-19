import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/modules/common/forget_password/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';

class UserForgetPasswordCubit extends Cubit<UserForgetPasswordStates> {
  UserForgetPasswordCubit() : super(UserForgetPasswordInitialState());

  static UserForgetPasswordCubit get(context) => BlocProvider.of(context);

  void userForgetPassword({
    required String email,
}) {
    emit(UserForgetPasswordLoadingState());
    DioHelper.postData(
      url: USERFORGETPASSWORD,
      baseUrl: BASEURL,
      data: {
        "Email": email,
      }
    ).then((value){
      final msg = value.data.toString();
      emit(UserForgetPasswordSuccessState(msg));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData[""][0];
          emit(UserForgetPasswordErrorState(errorMessage));
        }else{
          emit(UserForgetPasswordErrorState(error.toString()));
        }
    }else{
        emit(UserForgetPasswordErrorState(error.toString()));
      }
    });
  }
}
