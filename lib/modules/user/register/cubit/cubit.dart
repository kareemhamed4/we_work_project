import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/user/user_register_model.dart';
import 'package:we_work/modules/user/register/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';

class UserRegisterCubit extends Cubit<UserRegisterStates> {
  UserRegisterCubit() : super(UserRegisterInitialState());

  static UserRegisterCubit get(context) => BlocProvider.of(context);

  UserRegisterModel? userRegisterModel;
  void userRegister({
    required String name,
    required String email,
    required String city,
    required String country,
    required String experience,
    required String qualification,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String jobType,
}) {
    emit(UserRegisterLoadingState());
    DioHelper.postData(
      url: USERREGISTER,
      baseUrl: BASEURL,
      data: {
        "DisplayName": name,
        "Email": email,
        "City": city,
        "Country": country,
        "Experience": experience,
        "Qualification": qualification,
        "password": password,
        "ConfirmPassword": confirmPassword,
        "Phonenumber": phoneNumber,
        "JobType": jobType,
      }
    ).then((value){
      userRegisterModel = UserRegisterModel.fromJson(value.data);
      emit(UserRegisterSuccessState(userRegisterModel!));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data.toString();
          emit(UserRegisterErrorState(responseData!));
        }else{
          emit(UserRegisterErrorState(error.toString()));
        }
    }else{
        emit(UserRegisterErrorState(error.toString()));
      }
    });
  }
}
