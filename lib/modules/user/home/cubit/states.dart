import 'package:we_work/models/user/user_get_all_jobs_model.dart';
import 'package:we_work/models/user/user_get_freelance_details_model.dart';
import 'package:we_work/models/user/user_get_freelance_jobs_model.dart';
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

class UserGetAllFreelanceJobsLoadingState extends UserHomeStates {}
class UserGetAllFreelanceJobsSuccessState extends UserHomeStates {
  final List<UserGetFreelanceJobsModel> userGetFreelanceJobsModel;
  UserGetAllFreelanceJobsSuccessState(this.userGetFreelanceJobsModel);
}
class UserGetAllFreelanceJobsErrorState extends UserHomeStates {
  final String error;
  UserGetAllFreelanceJobsErrorState(this.error);
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

class UserGetFreelanceJobDetailsLoadingState extends UserHomeStates {}
class UserGetFreelanceJobDetailsSuccessState extends UserHomeStates {
  final UserGetFreelanceDetailsModel userGetFreelanceDetailsModel;
  UserGetFreelanceJobDetailsSuccessState(this.userGetFreelanceDetailsModel);
}
class UserGetFreelanceJobDetailsErrorState extends UserHomeStates {
  final String error;
  UserGetFreelanceJobDetailsErrorState(this.error);
}

class UserSendOfferToFreelanceJobLoadingState extends UserHomeStates {}
class UserSendOfferToFreelanceJobSuccessState extends UserHomeStates {
  final String msg;
  UserSendOfferToFreelanceJobSuccessState(this.msg);
}
class UserSendOfferToFreelanceJobErrorState extends UserHomeStates {
  final String error;
  UserSendOfferToFreelanceJobErrorState(this.error);
}