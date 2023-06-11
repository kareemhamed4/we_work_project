import 'package:we_work/models/user/user_get_profile_model.dart';

abstract class MainStates {}
class MainInitialState extends MainStates {}

class GetUserWithIdLoadingState extends MainStates {}
class GetUserWithIdSuccessState extends MainStates {
  final UserProfileModel userProfileModel;
  GetUserWithIdSuccessState(this.userProfileModel);
}
class GetUserWithIdErrorState extends MainStates {
  final String error;
  GetUserWithIdErrorState(this.error);
}