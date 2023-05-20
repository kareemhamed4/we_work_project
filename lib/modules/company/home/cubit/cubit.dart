import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/company/company_get_all_users_model.dart';
import 'package:we_work/modules/company/home/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class CompanyHomeCubit extends Cubit<CompanyHomeStates> {
  CompanyHomeCubit() : super(CompanyHomeInitialState());

  static CompanyHomeCubit get(context) => BlocProvider.of(context);

  CompanyGetAllUsersModel? companyGetAllUsersModel;
  void companyGetAllUsers() async {
    emit(CompanyGetAllUsersLoadingState());

    try {
      final response = await DioHelper.getData(
        url: COMPANYGETALLUSERS,
        baseUrl: BASEURL,
        token: companyToken,
      );
      companyGetAllUsersModel = CompanyGetAllUsersModel.fromJson(response.data);
      emit(CompanyGetAllUsersSuccessState(companyGetAllUsersModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"];
          emit(CompanyGetAllUsersErrorState(errorMessage));
        } else {
          emit(CompanyGetAllUsersErrorState(error.toString()));
        }
      } else {
        emit(CompanyGetAllUsersErrorState(error.toString()));
      }
    }
  }

  void companySendOfferToUser({
    required String message,
    required String uId,
}) async {
    emit(CompanySendOfferToUserLoadingState());
    try {
      await DioHelper.postData(
        url: "$COMPANYSENDOFFERTOUSER$uId",
        baseUrl: BASEURL,
        token: companyToken,
        data: {
          "Message":message
        }
      );
      emit(CompanySendOfferToUserSuccessState("Offer Created Successfully!"));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data.toString();
          emit(CompanySendOfferToUserErrorState(responseData!));
        } else {
          emit(CompanySendOfferToUserErrorState(error.toString()));
        }
      } else {
        emit(CompanySendOfferToUserErrorState(error.toString()));
      }
    }
  }

  Future<void> companyGetUserDetails({
    required int id,
}) async {
    emit(CompanyGetUserDetailsLoadingState());
    try {
      final response = await DioHelper.getData(
        url: "$COMPANYGETALLUSERS$id",
        baseUrl: BASEURL,
        token: companyToken,
      );
      companyGetAllUsersModel = CompanyGetAllUsersModel.fromJson(response.data);
      emit(CompanyGetUserDetailsSuccessState(companyGetAllUsersModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"];
          emit(CompanyGetUserDetailsErrorState(errorMessage));
        } else {
          emit(CompanyGetUserDetailsErrorState(error.toString()));
        }
      } else {
        emit(CompanyGetUserDetailsErrorState(error.toString()));
      }
    }
  }

}
