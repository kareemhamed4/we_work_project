import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:we_work/models/user/user_get_all_jobs_model.dart';
import 'package:we_work/models/user/user_get_freelance_jobs_model.dart';
import 'package:we_work/modules/user/filter/filter.dart';
import 'package:we_work/modules/user/freelance_details/freelance_details_screen.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/modules/user/job_details/job_details.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  var hasSpeech = false;
  SpeechToText speech = SpeechToText();
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  bool logEvents = false;

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
                        .headlineSmall!
                        .copyWith(color: myFavColor),
                  ),
            centerTitle: true,
            actions: [
              searchController.text.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      AvatarGlow(
                        endRadius: 35,
                        animate: hasSpeech,
                        duration: const Duration(milliseconds: 2000),
                        glowColor: myFavColor8,
                        repeatPauseDuration: const Duration(milliseconds: 100),
                        showTwoGlows: true,
                        child: GestureDetector(
                          onTapDown: (details) async {
                            if (!hasSpeech) {
                              var available = await speech.initialize();
                              if (available) {
                                setState(() {
                                  hasSpeech = true;
                                  speech.listen(
                                    onResult: resultListener,
                                    listenFor: const Duration(seconds: 60),
                                    pauseFor: const Duration(seconds: 3),
                                    partialResults: true,
                                    onSoundLevelChange: soundLevelListener,
                                    cancelOnError: true,
                                    listenMode: ListenMode.confirmation,
                                    localeId: "en_001",
                                  );
                                });
                              }
                            }
                          },
                          onTapUp: (details) async {
                            setState(() {
                              hasSpeech = false;
                            });
                            await speech.stop();
                            setState(() {
                              level = 0;
                            });
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: myFavColor,
                            child: Icon(
                              hasSpeech ? Icons.mic : Icons.mic_none,
                              color: myFavColor5,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: myTextFormField(
                          controller: searchController,
                          onChange: (value) {
                            setState(() {
                              if (searchController.text != value) {
                                searchController.text = value;
                              }
                            });
                            cubit.userGetSearchedJobs(
                                search: searchController.text);
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
                        child: Text(
                          "Available Jobs",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: myFavColor,
                                fontSize: 20.sp,
                              ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      if (cubit.userGetAllJobsModel != null)
                        if (cubit.userGetAllJobsModel!.count! > 0)
                          SizedBox(
                            height: 208.h,
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
                                        buildHomeJobCard(
                                          context: context,
                                          size: size,
                                          index: index,
                                          cubit: cubit,
                                          model: cubit.userGetAllJobsModel!,
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
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize: 20.sp,
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
                            height: 206.h,
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
                  if (cubit.userGetSearchedJobsModel != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildHomeJobCard(
                          context: context,
                          size: size,
                          index: index,
                          cubit: cubit,
                          model: cubit.userGetSearchedJobsModel!,
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                        itemCount: cubit.userGetSearchedJobsModel!.count!,
                      ),
                    ),
                if (searchController.text.isNotEmpty)
                  if (cubit.userGetSearchedJobsModel == null)
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

  Widget buildHomeJobCard({
    required Size size,
    required BuildContext context,
    required UserGetAllJobsModel model,
    required int index,
    required UserHomeCubit cubit,
  }) =>
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
        child: Container(
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
                          .copyWith(fontSize: 16.sp),
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
                            .copyWith(fontSize: 16.sp, color: myFavColor),
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
                          style: TextStyle(
                              fontSize: 20.sp, color: const Color(0xff649344)),
                        ),
                      ],
                    )
                  ]),
            ),
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
                                      .bodyLarge!
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
                        .copyWith(fontSize: 16.sp),
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
                          .copyWith(fontSize: 16.sp, color: myFavColor),
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
                        style: TextStyle(
                            fontSize: 20.sp, color: const Color(0xff649344)),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      );

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      searchController.text = result.recognizedWords;
    });
    UserHomeCubit.get(context)
        .userGetSearchedJobs(search: searchController.text);
  }

  void _logEvent(String eventDescription) {
    if (logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      debugPrint('$eventTime $eventDescription');
    }
  }
}
