import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

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
            ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
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
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: myFavColor),
            ),
            centerTitle: true,
          ),
          body: (cubit.userNotificationModel != null && cubit.userNotificationModel!.isNotEmpty)
              ? LiquidPullToRefresh(
                  key: _refreshIndicatorKey,
                  onRefresh: handleRefresh,
                  color: myFavColor,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const SizedBox(height: 12),
                              Text(
                                "You have",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                " ${cubit.userNotificationModel!.length} Notification",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: myFavColor),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 23.h),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.userNotificationModel!.length,
                            separatorBuilder: (context, index) => SizedBox(height: 23.h),
                            itemBuilder: (context, index) => buildNotificationItem(
                                  context: context,
                                  size: size,
                                  index: index,
                                  model: cubit.userNotificationModel!,
                                )),
                      ],
                    ),
                  ),
                )
              : (cubit.userNotificationModel != null && cubit.userNotificationModel!.isEmpty)
                  ? SizedBox(
                      width: double.infinity,
                      child: LiquidPullToRefresh(
                        key: _refreshIndicatorKey,
                        onRefresh: handleRefresh,
                        color: myFavColor,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'No Notification available right now',
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18.sp),
                              ),
                            ],
                          ),
                        ),
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
    return Slidable(
      startActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: ((context) {
            showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => AlertDialog(
                scrollable: true,
                icon: Icon(Icons.info_outline, color: myFavColor8),
                title: const Text("Warning"),
                content: const Text(
                    "Are you sure you want to delete this received offer ?"),
                actions: [
                  myMaterialButton(
                    context: context,
                    labelWidget: Text(
                      "Confirm",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        color: myFavColor5,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      UserNotificationCubit.get(context)
                          .userDeleteNotification(
                          meetingId: model[index].id!,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  myMaterialButton(
                    context: context,
                    bgColorForNotEnabled: myFavColor2,
                    isEnabled: false,
                    labelWidget: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        color: myFavColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 16),
                ],
                actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            );
          }),
          backgroundColor: myFavColor8,
          icon: Icons.delete_outline,
        ),
      ]),
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: ((context) {
            showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => AlertDialog(
                scrollable: true,
                icon: Icon(Icons.info_outline, color: myFavColor8),
                title: const Text("Warning"),
                content: const Text(
                    "Are you sure you want to delete this received offer ?"),
                actions: [
                  myMaterialButton(
                    context: context,
                    labelWidget: Text(
                      "Confirm",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        color: myFavColor5,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      UserNotificationCubit.get(context)
                          .userDeleteNotification(
                        meetingId: model[index].id!,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  myMaterialButton(
                    context: context,
                    bgColorForNotEnabled: myFavColor2,
                    isEnabled: false,
                    labelWidget: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        color: myFavColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 16),
                ],
                actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            );
          }),
          backgroundColor: myFavColor8,
          icon: Icons.delete_outline,
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                if (model[index].pictureUrl != null)
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: myFavColor3,
                    backgroundImage: NetworkImage(model[index].pictureUrl!),
                  ),
                if (model[index].pictureUrl == null)
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: myFavColor3,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: myFavColor4,
                    ),
                  ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model[index].user!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: myFavColor6),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        model[index].message!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                      ),
                    ],
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
        ),
      ),
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
                    "Company Name:",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor6, fontSize: 18),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    model[index].user!,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4, fontSize: 12),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Meeting Link: ",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor6, fontSize: 18),
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () {
                      LayoutCubit.get(context).launchZoomMeeting(meetingUrl: model[index].meetingLink);
                    },
                    child: Text(
                      model[index].meetingLink!,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.blueAccent, fontSize: 12, decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Meeting Date: ",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor6, fontSize: 18),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    model[index].meedtingDate!.substring(0, 10),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4, fontSize: 12),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Meeting Time: ",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor6, fontSize: 18),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    model[index].meedtingDate!.substring(12, 16),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4, fontSize: 12),
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
