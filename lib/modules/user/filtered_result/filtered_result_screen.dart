import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/models/user/user_get_all_jobs_model.dart';
import 'package:we_work/modules/user/filter/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/modules/user/job_details/job_details.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class FilterationChoices {
  final String? country;
  final String? city;
  final String? position;
  final dynamic salaryMin;
  final dynamic salaryMax;
  final String? experience;
  final String? jobType;
  FilterationChoices({
    this.country,
    this.city,
    this.position,
    this.salaryMin,
    this.salaryMax,
    this.experience,
    this.jobType,
  });
}

class FilteredResultScreen extends StatelessWidget {
  final UserGetAllJobsModel userGetFilteredJobs;
  const FilteredResultScreen({Key? key, required this.userGetFilteredJobs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilterationChoices filterationChoices = FilterationChoices(
      country: UserFilterJobsCubit.get(context).selectedCountry,
      city: UserFilterJobsCubit.get(context).selectedCity,
      position: UserFilterJobsCubit.get(context).selectedPosition,
      salaryMin: UserFilterJobsCubit.get(context).selectedMinSalary,
      salaryMax: UserFilterJobsCubit.get(context).selectedMaxSalary,
      experience: UserFilterJobsCubit.get(context).selectedExperience,
      jobType: UserFilterJobsCubit.get(context).selectedJobType,
    );
    String filterChoice = '';
    return BlocConsumer<UserHomeCubit, UserHomeStates>(
      listener: (context, state) {
        if (state is UserGetJobDetailsLoadingState) {
          showProgressIndicator(context);
        }
        if (state is UserGetJobDetailsSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          NavigateTo(
            context: context,
            widget: JobDetailsScreen(
              userGetJobDetailsModel:
                  UserHomeCubit.get(context).userGetJobDetailsModel!,
            ),
          );
        }
      },
      builder: (context, state) {
        UserHomeCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Filteration Result',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: myFavColor,

                  ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 40,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            filterChoice = filterationChoices.country ?? '';
                            break;
                          case 1:
                            filterChoice = filterationChoices.city ?? '';
                            break;
                          case 2:
                            filterChoice = filterationChoices.position ?? '';
                            break;
                          case 3:
                            filterChoice = filterationChoices.salaryMin != null
                                ? filterationChoices.salaryMin
                                    .toInt()
                                    .toString()
                                : '';
                            break;
                          case 4:
                            filterChoice = filterationChoices.salaryMax != null
                                ? filterationChoices.salaryMax
                                    .toInt()
                                    .toString()
                                : '';
                            break;
                          case 5:
                            filterChoice = filterationChoices.experience ?? '';
                            break;
                          case 6:
                            filterChoice = filterationChoices.jobType ?? '';
                            break;
                        }
                        return (filterChoice != "All" &&
                                filterChoice != "0" &&
                                filterChoice != "30000")
                            ? Container(
                                decoration: BoxDecoration(
                                  color: myFavColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      filterChoice,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontSize: 14.sp, color: myFavColor5),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                      separatorBuilder: (context, index) =>
                          (filterChoice != "All" &&
                                  filterChoice != "0" &&
                                  filterChoice != "30000")
                              ? const SizedBox(width: 15)
                              : const SizedBox.shrink(),
                      itemCount: 7,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                if (userGetFilteredJobs.count! > 0)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userGetFilteredJobs.count!,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          cubit
                              .userGetJobDetails(
                                id: userGetFilteredJobs.data![index].id!,
                              )
                              .then((value) {});
                        },
                        child: buildJobFilterationResultCard(
                          context: context,
                          index: index,
                          model: userGetFilteredJobs,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                    ),
                  ),
                if (userGetFilteredJobs.count! == 0)
                  const Center(
                      child: Text("No available jobs regard your filteration")),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildJobFilterationResultCard({
    required BuildContext context,
    required UserGetAllJobsModel model,
    required int index,
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
                            if (model.data![index].pictureUrl != null)
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: myFavColor3,
                                backgroundImage: NetworkImage(
                                    model.data![index].pictureUrl!),
                              ),
                            if (model.data![index].pictureUrl == null)
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
                                  model.data![index].user ?? "",
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
                                  model.data![index].title!,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                        FaIcon(
                          model.data![index].hasApplied!
                              ? FontAwesomeIcons.solidBookmark
                              : FontAwesomeIcons.bookmark,
                          color: myFavColor.withOpacity(0.5),
                          size: 20,
                        ),
                      ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    model.data![index].description ?? "",
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
                            "${model.data![index].city} , ${model.data![index].country}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Text(
                        "${model.data![index].salary} EG",
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
