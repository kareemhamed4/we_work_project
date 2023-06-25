import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:we_work/models/company/company_get_jobs_model.dart';
import 'package:we_work/models/user/user_get_freelance_jobs_model.dart';
import 'package:we_work/modules/company/company_job_details/company_job_details.dart';
import 'package:we_work/modules/company/home/cubit/cubit.dart';
import 'package:we_work/modules/company/home/cubit/states.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class CompanyJobsScreen extends StatefulWidget {
  const CompanyJobsScreen({super.key});

  @override
  State<CompanyJobsScreen> createState() => _CompanyJobsScreenState();
}

class _CompanyJobsScreenState extends State<CompanyJobsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CompanyHomeCubit, CompanyHomeStates>(
      listener: (context, state) {
        if (state is UserGetJobDetailsLoadingState) {
          showProgressIndicator(context);
        }
        if (state is CompanyDeleteHerJobLoadingState) {
          showProgressIndicator(context);
        }
        if (state is CompanyDeleteHerJobSuccessState) {
          Navigator.pop(context);
          buildSuccessToast(
            context: context,
            title: "Done!",
            description: state.msg,
          );
        }
        if (state is CompanyDeleteHerJobErrorState) {
          Navigator.pop(context);
          buildErrorToast(
            context: context,
            title: "Oops!",
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        CompanyHomeCubit cubit = BlocProvider.of(context);
        Future<void> handleRefresh() {
          final Completer<void> completer = Completer<void>();
          Timer(const Duration(seconds: 2), () {
            completer.complete();
          });
          cubit.companyGetHerJobs();
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
              'Company Jobs',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: myFavColor),
            ),
            centerTitle: true,
          ),
          body: cubit.companyGetJobsModel != null
              ? LiquidPullToRefresh(
                  key: _refreshIndicatorKey,
                  onRefresh: handleRefresh,
                  color: myFavColor,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        if (cubit.companyGetJobsModel!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ListView.separated(
                              shrinkWrap: true,
                              reverse: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cubit.companyGetJobsModel!.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  NavigateTo(
                                      context: context,
                                      widget: CompanyJobDetails(
                                        companyGetJobsModel:
                                            cubit.companyGetJobsModel![index],
                                      ));
                                },
                                child: buildCompanyJobCard(
                                  context: context,
                                  size: size,
                                  index: index,
                                  cubit: cubit,
                                  model: cubit.companyGetJobsModel!,
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 16,
                              ),
                            ),
                          ),
                        if (cubit.companyGetJobsModel!.isEmpty)
                          const Center(
                              child: Text(
                                  "You don't have any active jobs now, create now!")),
                      ],
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

  Widget buildCompanyJobCard({
    required Size size,
    required BuildContext context,
    required List<CompanyGetJobsModel> model,
    required int index,
    required CompanyHomeCubit cubit,
  }) =>
      Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  height: 5,
                                ),
                                Text(
                                  model[index].title ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: myFavColor6),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_forever_outlined, color: myFavColor8),
                          onPressed: () {
                            showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) => AlertDialog(
                                scrollable: true,
                                icon: Icon(Icons.info_outline,color: myFavColor8),
                                title: const Text("Warning"),
                                content: const Text("Are you sure you want to close this job ?"),
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
                                      cubit.companyDeleteHeyJob(jobId: model[index].id!);
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
                          }
                          ),
                      ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    model[index].description ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 14.sp),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "learn more",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14.sp, color: myFavColor),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Color(0xff649344),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${model[index].city} , ${model[index].country}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Text(
                        "${model[index].salary} EG",
                        style: const TextStyle(
                            fontSize: 18, color: Color(0xff649344)),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      );

  Widget buildCompanyFreelanceJobCard({
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model[index].projectOwner ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 14.sp,
                                        color: myFavColor7,
                                      ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  model[index].title ?? "",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                        FaIcon(
                          FontAwesomeIcons.bookmark,
                          color: myFavColor.withOpacity(0.5),
                          size: 20,
                        ),
                      ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    model[index].projectDetails ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 14.sp),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "learn more",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14.sp, color: myFavColor),
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
                        style: const TextStyle(
                            fontSize: 18, color: Color(0xff649344)),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      );
}
