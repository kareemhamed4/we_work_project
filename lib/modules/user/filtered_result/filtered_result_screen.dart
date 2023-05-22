import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/models/user/user_get_all_jobs_model.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/modules/user/job_details/job_details.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class FilteredResultScreen extends StatelessWidget {
  final UserGetAllJobsModel userGetFilteredJobs;
  const FilteredResultScreen({Key? key, required this.userGetFilteredJobs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserHomeCubit, UserHomeStates>(
      listener: (context, state) {
        if (state is UserGetJobDetailsLoadingState) {
          showProgressIndicator(context);
        }
      },
      builder: (context, state) {
        UserHomeCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Filteration Result',
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
                              .then((value) {
                            Navigator.pop(context);
                            NavigateTo(
                                context: context,
                                widget: JobDetailsScreen(
                                  userGetJobDetailsModel:
                                      cubit.userGetJobDetailsModel!,
                                ));
                          });
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
                            SvgPicture.asset("assets/image/google.svg"),
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
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: 14,
                                        color: myFavColor7,
                                      ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  model.data![index].title!,
                                  style: Theme.of(context).textTheme.bodyText1,
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
                        .caption!
                        .copyWith(fontSize: 14),
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
                          .caption!
                          .copyWith(fontSize: 14, color: myFavColor),
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
                            style: Theme.of(context).textTheme.bodyText2,
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
