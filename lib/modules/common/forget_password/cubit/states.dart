abstract class UserForgetPasswordStates{}
class UserForgetPasswordInitialState extends UserForgetPasswordStates {}
class UserForgetPasswordLoadingState extends UserForgetPasswordStates {}
class UserForgetPasswordSuccessState extends UserForgetPasswordStates {
  final String msg;
  UserForgetPasswordSuccessState(this.msg);
}
class UserForgetPasswordErrorState extends UserForgetPasswordStates {
  final String error;
  UserForgetPasswordErrorState(this.error);
}