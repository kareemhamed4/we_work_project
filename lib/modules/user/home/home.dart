import 'dart:async';
import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:we_work/cubit/cubit.dart';
import 'package:we_work/models/user/user_get_all_jobs_model.dart';
import 'package:we_work/modules/user/filter/filter.dart';
import 'package:we_work/modules/user/freelance_jobs/freelance_jobs_screen.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/modules/user/job_details/job_details.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();
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
      },
      builder: (context, state) {
        UserHomeCubit cubit = BlocProvider.of(context);
        Future<void> handleRefresh() {
          final Completer<void> completer = Completer<void>();
          Timer(const Duration(seconds: 2), () {
            completer.complete();
          });
          cubit.userGetAllJob();
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
            leading: searchController.text.isEmpty
                ? const SizedBox()
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
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: myFavColor),
                  ),
            centerTitle: true,
            actions: [
              searchController.text.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          NavigateTo(context: context, widget: FreelanceJobsScreen());
                        },
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
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
          body: LiquidPullToRefresh(
            key: _refreshIndicatorKey,
            onRefresh: handleRefresh,
            color: myFavColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                              cubit.userGetSearchedJobs(search: searchController.text);
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
                            decoration: BoxDecoration(color: myFavColor, borderRadius: BorderRadius.circular(4)
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
                                NavigateTo(context: context, widget: const UserFilterScreen());
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
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: myFavColor,
                                  fontSize: 20.sp,
                                ),
                          ),
                        ),
                        if (cubit.userGetAllJobsModel != null)
                          if (cubit.userGetAllJobsModel!.count! > 0)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cubit.userGetAllJobsModel!.count!,
                                itemBuilder: (context, index) => buildHomeJobCard(
                                  context: context,
                                  size: size,
                                  index: index,
                                  cubit: cubit,
                                  model: cubit.userGetAllJobsModel!,
                                ),
                                separatorBuilder: (context, index) => const SizedBox(
                                  height: 22,
                                ),
                              ),
                            ),
                        if (cubit.userGetAllJobsModel != null)
                          if (cubit.userGetAllJobsModel!.count! == 0)
                            const Center(child: Text("No available jobs right now")),
                        if (cubit.userGetAllJobsModel == null)
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
          cubit.userGetJobDetails(id: cubit.userGetAllJobsModel!.data![index].id!).then((value) {
            MainCubit.get(context)
                .getUserWithId(userId: cubit.userGetAllJobsModel!.data![index].appUserId!)
                .then((value) {
              Navigator.pop(context);
              NavigateTo(
                  context: context,
                  widget: JobDetailsScreen(
                    userGetJobDetailsModel: cubit.userGetJobDetailsModel!,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (model.data![index].pictureUrl != null)
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: myFavColor3,
                              backgroundImage: NetworkImage(model.data![index].pictureUrl!),
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
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                      color: myFavColor7,
                                    ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                model.data![index].title!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: myFavColor6, fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                      FaIcon(
                        model.data![index].hasApplied! ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                        color: myFavColor.withOpacity(0.5),
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    model.data![index].description ?? "",
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
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 14.sp,
                                  color: myFavColor7,
                                ),
                          ),
                        ],
                      ),
                      Text(
                        "${model.data![index].salary} EG",
                        style: TextStyle(fontSize: 16.sp, color: const Color(0xff649344)),
                      ),
                    ],
                  )
                ],
              ),
            ),
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
    _logEvent('Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      searchController.text = result.recognizedWords;
    });
    UserHomeCubit.get(context).userGetSearchedJobs(search: searchController.text);
  }

  void _logEvent(String eventDescription) {
    if (logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      debugPrint('$eventTime $eventDescription');
    }
  }
}
