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

class UserUploadCVLoadingState extends UserApplyJobStates {}
class UserUploadCVSuccessState extends UserApplyJobStates {
  final String msg;
  UserUploadCVSuccessState(this.msg);
}
class UserUploadCVErrorState extends UserApplyJobStates {
  final String error;
  UserUploadCVErrorState(this.error);
}