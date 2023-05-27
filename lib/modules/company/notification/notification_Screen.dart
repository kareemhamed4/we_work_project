import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:we_work/models/company/company_get_all_meetings_model.dart';
import 'package:we_work/modules/company/applied_job/applied_job_screen.dart';
import 'package:we_work/modules/company/notification/cubit/cubit.dart';
import 'package:we_work/modules/company/notification/cubit/states.dart';
import 'package:we_work/modules/company/offers/cubit/cubit.dart';
import 'package:we_work/modules/company/send_accept/send_accept_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyNotificationScreen extends StatefulWidget {
  const CompanyNotificationScreen({super.key});

  @override
  State<CompanyNotificationScreen> createState() =>
      _CompanyNotificationScreenState();
}

class _CompanyNotificationScreenState extends State<CompanyNotificationScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyGetUsersWhoAppliedCubit,
        CompanyGetUsersWhoAppliedStates>(
      listener: (context, state) {
        if(state is CompanyDeleteSentAcceptedOfferSuccessState){
          buildSuccessToast(
              context: context,
              title: "Deleted",
              description: "Meeting Canceled Successfully!",
          );
        }
        if (state is CompanyGetUserAppliedLoadingState) {
          showProgressIndicator(context);
        }
        if (state is CompanyGetUserAppliedSuccessState) {
          Navigator.pop(context);
          NavigateTo(context: context, widget: const AppliedJobScreen());
        }
      },
      builder: (context, state) {
        CompanyGetUsersWhoAppliedCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    onTap: (index) {
                      cubit.changeTabBarIndex(index);
                      cubit.currentIndexForTabBar = index;
                    },
                    indicatorWeight: 3,
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 16),
                    indicatorColor: myFavColor,
                    tabs: [
                      Tab(
                        height: 40,
                        child: Text(
                          "Notifications",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 18,
                                    color: cubit.currentIndexForTabBar == 0
                                        ? myFavColor
                                        : myFavColor4,
                                  ),
                        ),
                      ),
                      Tab(
                        height: 40,
                        child: Text(
                          "Meetings",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 18,
                                    color: cubit.currentIndexForTabBar == 1
                                        ? myFavColor
                                        : myFavColor4,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: (cubit.companyGetAllUsersApplied != null &&
                            cubit.companyMeetingsModel != null)
                        ? cubit.currentIndexForTabBar == 0
                            ? buildNotificationContent(context, cubit)
                            : cubit.companyMeetingsModel!.isNotEmpty
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        buildMeetingsCard(
                                            index: index,
                                            context: context,
                                            model: cubit.companyMeetingsModel!),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 20,
                                        ),
                                    itemCount:
                                        cubit.companyMeetingsModel!.length)
                                : Center(
                                    child: CircularProgressIndicator(
                                      color: myFavColor,
                                    ),
                                  )
                        : Center(
                            child: CircularProgressIndicator(
                              color: myFavColor,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildNotificationContent(
    BuildContext context,
    CompanyGetUsersWhoAppliedCubit cubit,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "You have ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "${cubit.companyGetAllUsersApplied!.length} Notification",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: myFavColor),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        if (cubit.companyGetAllUsersApplied!.isNotEmpty)
          ListView.separated(
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cubit.companyGetAllUsersApplied!.length,
            itemBuilder: (context, index) => Slidable(
              startActionPane: ActionPane(motion: const StretchMotion(), children: [
                SlidableAction(
                  onPressed: ((context) {
                    NavigateTo(context: context, widget: SendAcceptScreen(userId: cubit.companyGetAllUsersApplied![index].userId!,isFreelance: false,));
                  }),
                  backgroundColor: Colors.transparent,
                  icon: Icons.video_call_outlined,
                  foregroundColor: Colors.red,
                ),
              ]),
              endActionPane: ActionPane(motion: const StretchMotion(), children: [
                SlidableAction(
                  onPressed: ((context) {
                    NavigateTo(context: context, widget: SendAcceptScreen(userId: cubit.companyGetAllUsersApplied![index].userId!,isFreelance: false,));
                  }),
                  backgroundColor: Colors.transparent,
                  icon: Icons.video_call_outlined,
                  foregroundColor: Colors.red,
                ),
              ]),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  cubit.companyGetUserWhoApplied(id: cubit.companyGetAllUsersApplied![index].id!);
                },
                child: Row(
                  children: [
                    if (cubit.companyGetAllUsersApplied![index].pictureUrl !=
                        null)
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: myFavColor3,
                        backgroundImage: NetworkImage(
                            cubit.companyGetAllUsersApplied![index].pictureUrl!),
                      ),
                    if (cubit.companyGetAllUsersApplied![index].pictureUrl ==
                        null)
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: myFavColor3,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: myFavColor4,
                        ),
                      ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.companyGetAllUsersApplied![index].displayName ??
                                "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: myFavColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "applied for a your job as \"${cubit.companyGetAllUsersApplied![index].titleOfJob}\"",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => myDivider(height: 20),
          ),
        if (cubit.companyGetAllUsersApplied!.isEmpty)
          Center(
            child: Text(
              "You Don't have any applied jobs until now",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
      ],
    );
  }

  Widget buildMeetingsCard({
    required int index,
    required BuildContext context,
    required List<CompanyMeetingsModel> model,
  }) =>
      Slidable(
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: ((context) {
              CompanyGetUsersWhoAppliedCubit.get(context).companyDeleteAcceptedOffer(meetingId: model[index].id!);
            }),
            backgroundColor: myFavColor8,
            icon: Icons.delete_outline,
          ),
        ]),
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: ((context) {
              CompanyGetUsersWhoAppliedCubit.get(context).companyDeleteAcceptedOffer(meetingId: model[index].id!);
            }),
            backgroundColor: myFavColor8,
            icon: Icons.delete_outline,
          ),
        ]),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: myFavColor6.withAlpha(20),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 0)),
            ],
          ),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: myFavColor5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (model[index].pictureUrl != null)
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: myFavColor3,
                              backgroundImage:
                                  NetworkImage(model[index].pictureUrl!),
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
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  model[index].user ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 14.sp,
                                        color: myFavColor7,
                                      ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  model[index].message ?? "",
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: myFavColor6),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //kk
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month_outlined),
                            const SizedBox(
                              width: 11,
                            ),
                            Text(
                              model[index].meedtingDate != null
                                  ? model[index].meedtingDate!.substring(0, 10)
                                  : "",
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontSize: 14.sp,
                                        color: myFavColor7,
                                      ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: myMaterialButton(
                          context: context,
                          onPressed: () {
                            CompanyOffersCubit.get(context).launchZoomMeeting(
                              meetingUrl: model[index].meetingLink,
                            );
                          },
                          labelWidget: Text(
                            'Start Meeting',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
