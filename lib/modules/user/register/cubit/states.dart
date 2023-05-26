import 'package:we_work/models/user/user_register_model.dart';

abstract class UserRegisterStates{}
class UserRegisterInitialState extends UserRegisterStates {}
class ChangePasswordSuffixState extends UserRegisterStates {}
class ChangeConfirmPasswordSuffixState extends UserRegisterStates {}
class UserRegisterLoadingState extends UserRegisterStates {}
class UserRegisterSuccessState extends UserRegisterStates {
  final UserRegisterModel userRegisterModel;
  UserRegisterSuccessState(this.userRegisterModel);
}
class UserRegisterErrorState extends UserRegisterStates {
  final String error;
  UserRegisterErrorState(this.error);
}