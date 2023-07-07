import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/modules/company/add_job/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class CompanyAddJobCubit extends Cubit<CompanyAddJobStates> {
  CompanyAddJobCubit() : super(CompanyAddJobInitialState());

  static CompanyAddJobCubit get(context) => BlocProvider.of(context);

  String selectedJobType = "All";
  String selectedPosition = "All";

  String selectedJobCategory = "Software";
  List<String> jobCategories = [
    "Software",
    "Marketing",
    "Engineering",
    "DataEntry",
    "IT Specialist",
    "Other",
  ];

  String selectedExperience = "All";
  List<String> experienceList = [
    "All",
    "No Experience",
    "less than year",
    "1 year",
    "2-3 year",
    "more than 10 years"
  ];

  String selectedWorkPlace = "All";
  List<String> workPlaceList = [
    "All",
    "onSite",
    "Remotely",
  ];

  String selectedDisabledJobs = "none";
  List<String> disabledJobsList = [
    "none",
    "Hearing impairment",
    "Visual impairment",
    "Physical/mobility impairment",
    "Speech impairment",
  ];
  void companyAddJob({
    required String title,
    required String description,
    required String position,
    required String jobType,
    required String requirement,
    required String salary,
    required String city,
    required String country,
    required String experience,
    required String skill,
    required String workPlace,
    String? disabledJob,
    required String category,
}) {
    emit(CompanyAddJobLoadingState());
    DioHelper.postData(
      url: COMPANYCREATENORMALJOB,
      baseUrl: BASEURL,
      token: companyToken,
      data: {
        "Title": title,
        "Description": description,
        "Position": position,
        "JobType": jobType,
        "Requirement": requirement,
        "Category": category,
        "Salary": salary,
        "City": city,
        "Country": country,
        "Experience": experience,
        "Skill": skill,
        "WorkPlace": workPlace,
        "disabledJob": disabledJob ?? "",
      }
    ).then((value){
      emit(CompanyAddJobSuccessState(value.data.toString()));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          emit(CompanyAddJobErrorState("Unauthorized"));
        }else{
          emit(CompanyAddJobErrorState(error.toString()));
        }
    }else{
        emit(CompanyAddJobErrorState(error.toString()));
      }
    });
  }
}
