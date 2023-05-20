import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/user/user_register_model.dart';
import 'package:we_work/modules/company/register/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';

class CompanyRegisterCubit extends Cubit<CompanyRegisterStates> {
  CompanyRegisterCubit() : super(CompanyRegisterInitialState());

  static CompanyRegisterCubit get(context) => BlocProvider.of(context);

  UserRegisterModel? companyRegisterModel;
  void companyRegister({
    required String name,
    required String email,
    required String bio,
    required String city,
    required String country,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
}) {
    emit(CompanyRegisterLoadingState());
    DioHelper.postData(
      url: COMPANYREGISTER,
      baseUrl: BASEURL,
      data: {
        "DisplayName": name,
        "email": email,
        "bio": bio,
        "City": city,
        "Country": country,
        "phoneNumber": phoneNumber,
        "password": password,
        "ConfirmPassword": confirmPassword,
      }
    ).then((value){
      companyRegisterModel = UserRegisterModel.fromJson(value.data);
      emit(CompanyRegisterSuccessState(companyRegisterModel!));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data.toString();
          emit(CompanyRegisterErrorState(responseData!));
        }else{
          emit(CompanyRegisterErrorState(error.toString()));
        }
    }else{
        emit(CompanyRegisterErrorState(error.toString()));
      }
    });
  }
}
