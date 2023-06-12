import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/modules/company/add_freelance_job/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class CompanyAddFreelanceJobCubit extends Cubit<CompanyAddFreelanceJobStates> {
  CompanyAddFreelanceJobCubit() : super(CompanyAddFreelanceJobInitialState());

  static CompanyAddFreelanceJobCubit get(context) => BlocProvider.of(context);

  void companyAddFreelanceJob({
    required String title,
    required String projectStatus,
    required String timeToComplete,
    required String projectDetails,
    required String requiredSkills,
    required String budget,
}) {
    emit(CompanyAddFreelanceJobLoadingState());
    DioHelper.postData(
      url: COMPANYCREATEFREELANCEJOB,
      baseUrl: BASEURL,
      token: companyToken,
      data: {
        "title": title,
        "ProjectStatus": projectStatus,
        "TimeToComplete": timeToComplete,
        "ProjectDetails": projectDetails,
        "RequiredSkills": requiredSkills,
        "Budget": budget,
      }
    ).then((value){
      emit(CompanyAddFreelanceJobSuccessState(value.data.toString()));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          emit(CompanyAddFreelanceJobErrorState("Unauthorized"));
        }else{
          emit(CompanyAddFreelanceJobErrorState(error.toString()));
        }
    }else{
        emit(CompanyAddFreelanceJobErrorState(error.toString()));
      }
    });
  }
}
