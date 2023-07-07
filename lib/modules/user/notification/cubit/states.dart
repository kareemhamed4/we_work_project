import 'package:we_work/models/user/user_get_notification_model.dart';

abstract class UserNotificationStates{}
class UserNotificationInitialState extends UserNotificationStates {}
class UserNotificationLoadingState extends UserNotificationStates {}
class UserNotificationSuccessState extends UserNotificationStates {
  final List<UserNotificationModel>? userNotificationModel;
  UserNotificationSuccessState(this.userNotificationModel);
}
class UserNotificationErrorState extends UserNotificationStates {
  final String error;
  UserNotificationErrorState(this.error);
}

class UserDeleteNotificationLoadingState extends UserNotificationStates {}
class UserDeleteNotificationSuccessState extends UserNotificationStates {
  final String msg;
  UserDeleteNotificationSuccessState(this.msg);
}
class UserDeleteNotificationErrorState extends UserNotificationStates {
  final String error;
  UserDeleteNotificationErrorState(this.error);
}