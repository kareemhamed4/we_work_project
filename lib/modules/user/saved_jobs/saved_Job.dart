import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_work/models/user/user_get_applied_jobs_model.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/saved_jobs/cubit/cubit.dart';
import 'package:we_work/modules/user/saved_jobs/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class SavedJob extends StatelessWidget {
  const SavedJob({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Applied Job',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: myFavColor, fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                            mySizedBox(size: size, myHeight: 20),
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
              context
                  .read<UserGetAppliedJobsCubit>()
                  .deleteApplicant(applicantId: model[index].applicantId!);
            }),
            backgroundColor: myFavColor8,
            icon: Icons.delete_outline,
          ),
        ]),
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: ((context) {
              context
                  .read<UserGetAppliedJobsCubit>()
                  .deleteApplicant(applicantId: model[index].applicantId!);
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/image/google.svg"),
                      const SizedBox(
                        width: 26,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model[index].name ?? "",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14,
                                      color: myFavColor7,
                                    ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            model[index].title ?? "",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    model[index].message!,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 16,
                          color: myFavColor7,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined),
                          const SizedBox(
                            width: 11,
                          ),
                          Text(
                            model[index].dateApplied != null
                                ? model[index].dateApplied!.substring(0, 10)
                                : "",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14,
                                      color: myFavColor7,
                                    ),
                          )
                        ],
                      ),
                      Text(
                        "Job Id:${model[index].jobid ?? ""}",
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 16,
                              color: myFavColor.withOpacity(0.8),
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
