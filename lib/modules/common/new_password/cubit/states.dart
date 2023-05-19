abstract class UserNewPasswordStates{}
class UserNewPasswordInitialState extends UserNewPasswordStates {}
class UserNewPasswordLoadingState extends UserNewPasswordStates {}
class UserNewPasswordSuccessState extends UserNewPasswordStates {
  final String msg;
  UserNewPasswordSuccessState(this.msg);
}
class UserNewPasswordErrorState extends UserNewPasswordStates {
  final String error;
  UserNewPasswordErrorState(this.error);
}