abstract class UserApplyJobStates{}
class UserApplyJobInitialState extends UserApplyJobStates {}
class FilePickedSuccessState extends UserApplyJobStates {}
class FilePickedErrorState extends UserApplyJobStates {}
class FileDeletedSuccessState extends UserApplyJobStates {}
class UserApplyJobLoadingState extends UserApplyJobStates {}
class UserApplyJobSuccessState extends UserApplyJobStates {
  final String msg;
  UserApplyJobSuccessState(this.msg);
}
class UserApplyJobErrorState extends UserApplyJobStates {
  final String error;
  UserApplyJobErrorState(this.error);
}