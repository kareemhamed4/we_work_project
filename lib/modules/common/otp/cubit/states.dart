abstract class UserVerifyOTPStates{}
class UserVerifyOTPInitialState extends UserVerifyOTPStates {}
class UserVerifyOTPLoadingState extends UserVerifyOTPStates {}
class UserVerifyOTPSuccessState extends UserVerifyOTPStates {
  final String msg;
  UserVerifyOTPSuccessState(this.msg);
}
class UserVerifyOTPErrorState extends UserVerifyOTPStates {
  final String error;
  UserVerifyOTPErrorState(this.error);
}