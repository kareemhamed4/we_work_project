import 'package:we_work/models/user/user_get_all_jobs_model.dart';
import 'package:we_work/models/user/user_get_job_details_model.dart';

abstract class UserHomeStates{}
class UserHomeInitialState extends UserHomeStates {}
class ChangeZoomDrawerState extends UserHomeStates {}

class UserGetAllJobsLoadingState extends UserHomeStates {}
class UserGetAllJobsSuccessState extends UserHomeStates {
  final UserGetAllJobsModel userGetAllJobsModel;
  UserGetAllJobsSuccessState(this.userGetAllJobsModel);
}
class UserGetAllJobsErrorState extends UserHomeStates {
  final String error;
  UserGetAllJobsErrorState(this.error);
}

class UserGetJobDetailsLoadingState extends UserHomeStates {}
class UserGetJobDetailsSuccessState extends UserHomeStates {
  final UserGetJobDetailsModel userGetJobDetailsModel;
  UserGetJobDetailsSuccessState(this.userGetJobDetailsModel);
}
class UserGetJobDetailsErrorState extends UserHomeStates {
  final String error;
  UserGetJobDetailsErrorState(this.error);
}