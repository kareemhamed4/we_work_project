import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/layout_company/cubit/cubit.dart';
import 'package:we_work/models/user/user_get_all_jobs_model.dart';
import 'package:we_work/models/user/user_get_freelance_jobs_model.dart';
import 'package:we_work/modules/user/filter/filter.dart';
import 'package:we_work/modules/user/freelance_details/freelance_details_screen.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/modules/user/job_details/job_details.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';
import 'package:we_work/test/cubit/cubit.dart';

//ignore: must_be_immutable
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserHomeCubit, UserHomeStates>(
      listener: (context, state) {
        if (state is UserGetJobDetailsLoadingState) {
          showProgressIndicator(context);
        }
        if (state is UserGetFreelanceJobDetailsLoadingState) {
          showProgressIndicator(context);
        }
      },
      builder: (context, state) {
        UserHomeCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            leading: searchController.text.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: IconButton(
                      icon: Icon(
                        Icons.sort_outlined,
                        color: myFavColor6,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          ZoomDrawer.of(context)?.open();
                        });
                      },
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      color: myFavColor,
                    ),
                  ),
            title: searchController.text.isEmpty
                ? const SizedBox.shrink()
                : Text(
                    'Search result',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: myFavColor, fontSize: 20),
                  ),
            centerTitle: true,
            actions: [
              searchController.text.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: GestureDetector(
                        onTap: (){
                          CVCubit.get(context).chooseCVFile();
                        },
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: myFavColor7,
                                blurRadius: 2, // adjust the blur radius here
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "assets/image/Frame 34.png",
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: myTextFormField(
                          controller: searchController,
                          onChange: (value) {
                            setState(() {
                              if (searchController.text != value) {
                                searchController.text = value;
                              }
                            });
                          },
                          context: context,
                          hint: "Search",
                          suffixIcon: const Icon(Icons.search),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9),
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              color: myFavColor,
                              borderRadius: BorderRadius.circular(4)
                              //more than 50% of width makes circle
                              ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 25,
                            ),
                            color: Colors.black,
                            onPressed: () {
                              NavigateTo(
                                  context: context, widget: const Filter());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                if (searchController.text.isEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: GestureDetector(
                          onTap: (){
                            LayoutCompanyCubit.get(context).createZoomMeeting(topic: "this is topics From Api from 11 Am     ", agenda: "this is agenda", date: "2023-05-30", time: "11", duration: 30);
                            //print(LayoutCompanyCubit.get(context).meetingUrl);
                            //LayoutCompanyCubit.get(context).launchZoomMeeting();
                          },
                          child: Text(
                            "Available Jobs",
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontSize: 20,
                                      color: myFavColor,
                                    ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 20 / size.height,
                      ),
                      if (cubit.userGetAllJobsModel != null)
                        if (cubit.userGetAllJobsModel!.count! > 0)
                          SizedBox(
                            height: size.height * 192 / 780,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: cubit.userGetAllJobsModel!.count!,
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
                                        GestureDetector(
                                          onTap: () {
                                            cubit
                                                .userGetJobDetails(
                                                    id: cubit
                                                        .userGetAllJobsModel!
                                                        .data![index]
                                                        .id!)
                                                .then((value) {
                                              cubit
                                                  .getUserWithId(
                                                      userId: cubit
                                                          .userGetAllJobsModel!
                                                          .data![index]
                                                          .appUserId!)
                                                  .then((value) {
                                                Navigator.pop(context);
                                                NavigateTo(
                                                    context: context,
                                                    widget: JobDetailsScreen(
                                                      userGetJobDetailsModel: cubit
                                                          .userGetJobDetailsModel!,
                                                    ));
                                              });
                                            });
                                          },
                                          child: buildHomeJobCard(
                                            context: context,
                                            size: size,
                                            index: index,
                                            model: cubit.userGetAllJobsModel!,
                                          ),
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
                      if (cubit.userGetAllJobsModel != null)
                        if (cubit.userGetAllJobsModel!.count! == 0)
                          const Center(
                              child: Text("No available jobs right now")),
                      if (cubit.userGetAllJobsModel == null)
                        Center(
                            child: CircularProgressIndicator(
                          color: myFavColor,
                        )),
                      SizedBox(
                        height: size.height * 20 / size.height,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          "Freelancing Jobs",
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontSize: 20,
                                    color: myFavColor,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 20 / size.height,
                      ),
                      if (cubit.userGetFreelanceJobsModel != null)
                        if (cubit.userGetFreelanceJobsModel!.isNotEmpty)
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
                                        GestureDetector(
                                          onTap: () {
                                            cubit
                                                .userGetFreelanceJobDetails(
                                              id: cubit
                                                  .userGetFreelanceJobsModel![
                                                      index]
                                                  .id!,
                                            )
                                                .then((value) {
                                              Navigator.pop(context);
                                              NavigateTo(
                                                  context: context,
                                                  widget:
                                                      FreelanceDetailsScreen(
                                                    userGetFreelanceDetailsModel:
                                                        cubit
                                                            .userGetFreelanceDetailsModel!,
                                                    id: cubit
                                                        .userGetFreelanceJobsModel![
                                                            index]
                                                        .id!,
                                                    pictureUrl: cubit
                                                            .userGetFreelanceJobsModel![
                                                                index]
                                                            .pictureUrl ??
                                                        "null",
                                                  ));
                                            });
                                          },
                                          child: buildHomeFreelanceJobCard(
                                            context: context,
                                            size: size,
                                            index: index,
                                            model: cubit
                                                .userGetFreelanceJobsModel!,
                                          ),
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
                      if (cubit.userGetFreelanceJobsModel != null)
                        if (cubit.userGetFreelanceJobsModel!.isEmpty)
                          const Center(
                              child: Text(
                                  "No available Freelance jobs right now")),
                      if (cubit.userGetFreelanceJobsModel == null)
                        Center(
                            child: CircularProgressIndicator(
                          color: myFavColor,
                        )),
                    ],
                  ),
                if (searchController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildHomeJobCard(
                        context: context,
                        size: size,
                        index: index,
                        model: cubit.userGetAllJobsModel!,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      itemCount: 3,
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildHomeJobCard({
    required Size size,
    required BuildContext context,
    required UserGetAllJobsModel model,
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
