import 'package:we_work/models/user/user_get_applied_jobs_model.dart';

abstract class UserGetAppliedJobsStates{}
class UserGetAppliedJobsInitialState extends UserGetAppliedJobsStates {}
class UserGetAppliedJobsLoadingState extends UserGetAppliedJobsStates {}
class UserGetAppliedJobsSuccessState extends UserGetAppliedJobsStates {
  final List<UserGetAppliedJobsModel> getAppliedJobsModel;
  UserGetAppliedJobsSuccessState(this.getAppliedJobsModel);
}
class UserGetAppliedJobsErrorState extends UserGetAppliedJobsStates {
  final String error;
  UserGetAppliedJobsErrorState(this.error);
}

class UserDeleteApplicantLoadingState extends UserGetAppliedJobsStates {}
class UserDeleteApplicantSuccessState extends UserGetAppliedJobsStates {
  final String msg;
  UserDeleteApplicantSuccessState(this.msg);
}
class UserDeleteApplicantErrorState extends UserGetAppliedJobsStates {
  final String error;
  UserDeleteApplicantErrorState(this.error);
}