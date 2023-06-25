import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:we_work/cubit/cubit.dart';
import 'package:we_work/cubit/states.dart';
import 'package:we_work/models/user/user_get_applied_jobs_model.dart';
import 'package:we_work/modules/common/user_details/user_details_screen.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/saved_jobs/cubit/cubit.dart';
import 'package:we_work/modules/user/saved_jobs/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class SavedJob extends StatelessWidget {
  SavedJob({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is GetUserWithIdLoadingState) {
          showProgressIndicator(context);
        }
        if (state is GetUserWithIdSuccessState) {
          Navigator.pop(context);
          NavigateTo(
              context: context,
              widget: UserDetailsScreen(
                  isCompany: state.userProfileModel.dateOfCreation != null
                      ? true
                      : false));
        }
        if (state is GetUserWithIdErrorState) {
          Navigator.pop(context);
          buildErrorToast(
              context: context, title: "Oops!", description: state.error);
        }
      },
      builder: (context, state) {
        return BlocConsumer<UserGetAppliedJobsCubit, UserGetAppliedJobsStates>(
          listener: (context, state) {
            if (state is UserDeleteApplicantSuccessState) {
              UserHomeCubit.get(context).userGetAllJob();
              buildSuccessToast(
                title: "Done",
                context: context,
                description: "Applicant Deleted Successfully!",
              );
            }
            if (state is UserDeleteApplicantErrorState) {
              buildSuccessToast(
                title: "Oops",
                context: context,
                description: "Applicant Deleted Failed!",
              );
            }
          },
          builder: (context, state) {
            UserGetAppliedJobsCubit cubit = BlocProvider.of(context);
            Future<void> handleRefresh() {
              final Completer<void> completer = Completer<void>();
              Timer(const Duration(seconds: 2), () {
                completer.complete();
              });
              cubit.userGetAppliedJobs();
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
                  'Applied Job',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: myFavColor),
                ),
                centerTitle: true,
              ),
              body: LiquidPullToRefresh(
                key: _refreshIndicatorKey,
                onRefresh: handleRefresh,
                color: myFavColor,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      if (cubit.getAppliedJobsModel != null)
                        if (cubit.getAppliedJobsModel!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ListView.separated(
                              shrinkWrap: true,
                              reverse: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => buildSavedJobs(
                                  context: context,
                                  index: index,
                                  size: size,
                                  model: cubit.getAppliedJobsModel!),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 20.h),
                              itemCount: cubit.getAppliedJobsModel!.length,
                            ),
                          ),
                      if (cubit.getAppliedJobsModel != null)
                        if (cubit.getAppliedJobsModel!.isEmpty)
                          const Center(child: Text("No Applicant Found!")),
                      if (cubit.getAppliedJobsModel == null)
                        Center(
                            child: CircularProgressIndicator(
                          color: myFavColor,
                        )),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSavedJobs({
    required Size size,
    required BuildContext context,
    required int index,
    required List<UserGetAppliedJobsModel> model,
  }) =>
      Slidable(
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: ((context) {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => AlertDialog(
                  scrollable: true,
                  icon: Icon(Icons.info_outline,color: myFavColor8),
                  title: const Text("Warning"),
                  content: const Text("Are you sure you want to Delete this applicant ?"),
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
                        context.read<UserGetAppliedJobsCubit>().deleteApplicant(
                              applicantId: model[index].applicantId!,
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
                  icon: Icon(Icons.info_outline,color: myFavColor8),
                  title: const Text("Warning"),
                  content: const Text("Are you sure you want to Delete this applicant ?"),
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
                        context.read<UserGetAppliedJobsCubit>().deleteApplicant(
                          applicantId: model[index].applicantId!,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      MainCubit.get(context)
                          .getUserWithId(userId: model[index].userId!);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (model[index].piCtrueUrl != null)
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: myFavColor3,
                            backgroundImage:
                                NetworkImage(model[index].piCtrueUrl!),
                          ),
                        if (model[index].piCtrueUrl == null)
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: myFavColor3,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: myFavColor4,
                            ),
                          ),
                        const SizedBox(
                          width: 26,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model[index].name ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 14,
                                    color: myFavColor7,
                                  ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              model[index].title ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: myFavColor6, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    model[index].message ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 14.sp),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_month_outlined),
                      const SizedBox(
                        width: 11,
                      ),
                      Text(
                        model[index].dateApplied != null
                            ? model[index].dateApplied!.substring(0, 10)
                            : "",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 14.sp,
                              color: myFavColor7,
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
