import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/models/user/user_get_notification_model.dart';
import 'package:we_work/modules/user/notification/cubit/cubit.dart';
import 'package:we_work/modules/user/notification/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserNotificationCubit, UserNotificationStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserNotificationCubit cubit = BlocProvider.of(context);
        Future<void> handleRefresh() {
          final Completer<void> completer = Completer<void>();
          Timer(const Duration(seconds: 2), () {
            completer.complete();
          });
          cubit.userGetNotification();
          return completer.future.then<void>((_) {
            ScaffoldMessenger.of(_scaffoldKey.currentState!.context)
                .showSnackBar(
              SnackBar(
                content: const Text('Refresh complete'),
                action: SnackBarAction(
                  label: 'RETRY',
                  textColor: myFavColor5,
                  onPressed: () {
                    _refreshIndicatorKey.currentState!.show();
                  },
                ),
              ),
            );
          });
        }
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              'Notification',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: myFavColor),
            ),
            centerTitle: true,
          ),
          body: (cubit.userNotificationModel != null &&
                  cubit.userNotificationModel!.isNotEmpty)
              ? LiquidPullToRefresh(
                  key: _refreshIndicatorKey,
                  onRefresh: handleRefresh,
                  color: myFavColor,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "You have",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                " ${cubit.userNotificationModel!.length} Notification",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: myFavColor),
                              ),
                            ],
                          ),
                          SizedBox(height: 23.h),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cubit.userNotificationModel!.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 23.h),
                              itemBuilder: (context, index) =>
                                  buildNotificationItem(
                                    context: context,
                                    size: size,
                                    index: index,
                                    model: cubit.userNotificationModel!,
                                  )),
                        ],
                      ),
                    ),
                  ),
                )
              : (cubit.userNotificationModel != null &&
                      cubit.userNotificationModel!.isEmpty)
                  ? SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No Notification available right now',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 18.sp),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                      color: myFavColor,
                    )),
        );
      },
    );
  }

  Widget buildNotificationItem({
    required BuildContext context,
    required Size size,
    required int index,
    required List<UserNotificationModel> model,
  }) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(model[index].pictureUrl!)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                model[index].message!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: myMaterialButton(
                  context: context,
                  labelWidget: Text(
                    "Show Details",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  onPressed: () {
                    buildAcceptedDialog(
                      context: context,
                      size: size,
                      model: model,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        myDivider(),
      ],
    );
  }

  void buildAcceptedDialog({
    required BuildContext context,
    required Size size,
    required int index,
    required List<UserNotificationModel> model,
  }) {
    showDialog<String>(
      context: context,
      builder: (dialogContext) => Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: size.width - 60,
            decoration: BoxDecoration(
              color: myFavColor5,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Meeting Link: ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor6, fontSize: 18),
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () {
                      LayoutCubit.get(context).launchZoomMeeting(
                          meetingUrl: model[index].meetingLink);
                    },
                    child: Text(
                      model[index].meetingLink!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.blueAccent,
                          fontSize: 12,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Meeting Date: ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor6, fontSize: 18),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    model[index].meedtingDate!.substring(0, 10),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 12),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Meeting Time: ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor6, fontSize: 18),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    model[index].meedtingDate!.substring(12, 16),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
