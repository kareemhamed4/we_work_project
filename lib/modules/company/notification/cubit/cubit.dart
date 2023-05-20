import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/company/company_get_user_applied_model.dart';
import 'package:we_work/modules/company/notification/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class CompanyGetUsersWhoAppliedCubit extends Cubit<CompanyGetUsersWhoAppliedStates> {
  CompanyGetUsersWhoAppliedCubit() : super(CompanyGetUsersWhoAppliedInitialState());

  static CompanyGetUsersWhoAppliedCubit get(context) => BlocProvider.of(context);

  List<CompanyGetAllUsersApplied>? companyGetAllUsersApplied;
  Future<void> companyGetAllUsersWhoApplied() async{
    emit(CompanyGetUsersWhoAppliedLoadingState());
    DioHelper.getData(
      url: COMPANYGETALLUSERSWHOAPPLIED,
      baseUrl: BASEURL,
      token: companyToken,
    ).then((value){
      List<dynamic> responseList = value.data;
      companyGetAllUsersApplied = responseList.map((json) {
        return CompanyGetAllUsersApplied.fromJson(json);
      }).toList();
      emit(CompanyGetUsersWhoAppliedSuccessState(companyGetAllUsersApplied!));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          emit(CompanyGetUsersWhoAppliedErrorState("Unauthorized"));
        }else{
          emit(CompanyGetUsersWhoAppliedErrorState(error.toString()));
        }
    }
      else{
        emit(CompanyGetUsersWhoAppliedErrorState(error.toString()));
      }
    });
  }
}
