import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:we_work/cubit/cubit.dart';
import 'package:we_work/cubit/states.dart';
import 'package:we_work/models/user/user_get_freelance_jobs_model.dart';
import 'package:we_work/modules/common/user_details/user_details_screen.dart';
import 'package:we_work/modules/user/freelance_details/freelance_details_screen.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class FreelanceJobsScreen extends StatelessWidget {
  FreelanceJobsScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<MainCubit,MainStates>(
      listener: (context, state) {
        if (state is GetUserWithIdLoadingState) {
          showProgressIndicator(context);
        }
        if (state is GetUserWithIdSuccessState) {
          Navigator.pop(context);
          NavigateTo(
              context: context,
              widget: UserDetailsScreen(isCompany: state.userProfileModel.dateOfCreation != null ? true : false));
        }
        if (state is GetUserWithIdErrorState) {
          Navigator.pop(context);
          buildErrorToast(context: context, title: "Oops!", description: state.error);
        }
      },
      builder: (context,state){
        return BlocConsumer<UserHomeCubit, UserHomeStates>(
          listener: (context, state) {
            if (state is UserGetFreelanceJobDetailsLoadingState) {
              showProgressIndicator(context);
            }
          },
          builder: (context, state) {
            UserHomeCubit cubit = BlocProvider.of(context);
            Future<void> handleRefresh() {
              final Completer<void> completer = Completer<void>();
              Timer(const Duration(seconds: 2), () {
                completer.complete();
              });
              cubit.userGetAllFreelanceJobs();
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
                  'Freelancing Jobs',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: myFavColor),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (cubit.userGetFreelanceJobsModel != null)
                            if (cubit.userGetFreelanceJobsModel!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cubit.userGetFreelanceJobsModel!.length,
                                  itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      cubit
                                          .userGetFreelanceJobDetails(
                                        id: cubit.userGetFreelanceJobsModel![index].id!,
                                      )
                                          .then((value) {
                                        Navigator.pop(context);
                                        NavigateTo(
                                            context: context,
                                            widget: FreelanceDetailsScreen(
                                              userGetFreelanceDetailsModel: cubit.userGetFreelanceDetailsModel!,
                                              id: cubit.userGetFreelanceJobsModel![index].id!,
                                              pictureUrl: cubit.userGetFreelanceJobsModel![index].pictureUrl ?? "null",
                                            ));
                                      });
                                    },
                                    child: buildHomeFreelanceJobCard(
                                      context: context,
                                      size: size,
                                      index: index,
                                      model: cubit.userGetFreelanceJobsModel!,
                                    ),
                                  ),
                                  separatorBuilder: (context, index) => const SizedBox(
                                    height: 22,
                                  ),
                                ),
                              ),
                          if (cubit.userGetFreelanceJobsModel != null)
                            if (cubit.userGetFreelanceJobsModel!.isEmpty)
                              const Center(child: Text("No available Freelance jobs right now")),
                          if (cubit.userGetFreelanceJobsModel == null)
                            Center(
                              child: CircularProgressIndicator(
                                color: myFavColor,
                              ),
                            ),
                        ],
                      ),
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

  Widget buildHomeFreelanceJobCard({
    required Size size,
    required BuildContext context,
    required List<UserGetFreelanceJobsModel> model,
    required int index,
  }) =>
      Container(
        width: size.width - 40,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: myFavColor6.withAlpha(20), spreadRadius: 2, blurRadius: 7, offset: const Offset(0, 0)),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      MainCubit.get(context).getUserWithId(userId: model[index].userId!);
                    },
                    child: Row(
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
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model[index].projectOwner ?? "",
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 14,
                                    color: myFavColor7,
                                  ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              model[index].title ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: myFavColor6, fontSize: 14.sp),
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
                    model[index].projectDetails ?? "",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14.sp),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "learn more",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14.sp, color: myFavColor),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${model[index].budget ?? ""} EG",
                        style: TextStyle(fontSize: 16.sp, color: const Color(0xff649344)),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      );
}
