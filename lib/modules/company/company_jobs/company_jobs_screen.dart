import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CompanyHomeCubit, CompanyHomeStates>(
      listener: (context, state) {
        if (state is UserGetJobDetailsLoadingState) {
          showProgressIndicator(context);
        }
      },
      builder: (context, state) {
        CompanyHomeCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Company Jobs',
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
                if (cubit.companyGetJobsModel != null)
                  if (cubit.companyGetJobsModel!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.companyGetJobsModel!.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            NavigateTo(context: context, widget: CompanyJobDetails(companyGetJobsModel: cubit.companyGetJobsModel![index],));
                          },
                          child: buildCompanyJobCard(
                            context: context,
                            size: size,
                            index: index,
                            isSaved: false,
                            model: cubit.companyGetJobsModel!,
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                      ),
                    ),
                if (cubit.companyGetJobsModel != null)
                  if (cubit.companyGetJobsModel!.isEmpty)
                    const Center(
                        child: Text(
                            "You don't have any active jobs now, create now!")),
                if (cubit.companyGetJobsModel == null)
                  Center(
                      child: CircularProgressIndicator(
                    color: myFavColor,
                  )),
                /*SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "Company Freelancing Jobs",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 20,
                          color: myFavColor,
                        ),
                  ),
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                if (cubit.companyGetJobsModel != null)
                    SizedBox(
                      height: size.height * 192 / 780,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              cubit.userGetFreelanceJobsModel!.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  buildCompanyFreelanceJobCard(
                                    context: context,
                                    size: size,
                                    index: index,
                                    isSaved: false,
                                    model: cubit.userGetFreelanceJobsModel!,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(
                            width: 10,
                          ),
                        ),
                      ),
                    ),
                  if (cubit.companyGetJobsModel == null)
                    Center(
                        child: CircularProgressIndicator(
                      color: myFavColor,
                    )),*/
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCompanyJobCard({
    required Size size,
    required BuildContext context,
    required List<CompanyGetJobsModel> model,
    required int index,
    bool isSaved = false,
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
                                  model[index].title ?? "",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.delete_forever_outlined,
                          color: myFavColor8,
                        ),
                      ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    model[index].description ?? "",
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
                            "${model[index].city} , ${model[index].country}",
                            style: Theme.of(context).textTheme.bodyText2,
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
    bool isSaved = false,
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
                            SvgPicture.asset("assets/image/google.svg"),
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
                                  model[index].title ?? "",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ],
                        ),
                        FaIcon(
                          isSaved
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
                    model[index].projectDetails ?? "",
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
