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