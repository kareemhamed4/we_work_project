import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/models/user/user_get_notification_model.dart';
import 'package:we_work/modules/user/notification/cubit/cubit.dart';
import 'package:we_work/modules/user/notification/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserNotificationCubit, UserNotificationStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserNotificationCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Notification',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: myFavColor, fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: (cubit.userNotificationModel != null &&
                  cubit.userNotificationModel!.isNotEmpty)
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "You have",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Text(
                              " ${cubit.userNotificationModel!.length} Notification",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: myFavColor),
                            ),
                          ],
                        ),
                        mySizedBox(size: size, myHeight: 23),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.userNotificationModel!.length,
                            separatorBuilder: (context, index) =>
                                mySizedBox(size: size, myHeight: 23),
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
                                .headline5!
                                .copyWith(fontSize: 16),
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

  Column buildNotificationItem({
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
                style: Theme.of(context).textTheme.bodyText2,
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
                    style: Theme.of(context).textTheme.button,
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
                  mySizedBox(size: size, myHeight: 12),
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
                  mySizedBox(size: size, myHeight: 20),
                  Text(
                    "Meeting Date: ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor6, fontSize: 18),
                  ),
                  mySizedBox(size: size, myHeight: 12),
                  Text(
                    model[index].meedtingDate!.substring(0, 10),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 12),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  Text(
                    "Meeting Time: ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor6, fontSize: 18),
                  ),
                  mySizedBox(size: size, myHeight: 12),
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
