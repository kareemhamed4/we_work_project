import 'dart:async';
import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:rate/rate.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:we_work/cubit/cubit.dart';
import 'package:we_work/cubit/states.dart';
import 'package:we_work/layout_company/cubit/cubit.dart';
import 'package:we_work/models/company/company_get_all_users_model.dart';
import 'package:we_work/modules/common/user_details/user_details_screen.dart';
import 'package:we_work/modules/company/company_jobs/company_jobs_screen.dart';
import 'package:we_work/modules/company/filter/filter.dart';
import 'package:we_work/modules/company/home/cubit/cubit.dart';
import 'package:we_work/modules/company/home/cubit/states.dart';
import 'package:we_work/modules/company/message_for_offer/message_for_offer_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
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
    return BlocConsumer<MainCubit, MainStates>(
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
      builder: (context, state) {
        return BlocConsumer<CompanyHomeCubit, CompanyHomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            CompanyHomeCubit cubit = BlocProvider.of(context);
            Future<void> handleRefresh() {
              final Completer<void> completer = Completer<void>();
              Timer(const Duration(seconds: 2), () {
                completer.complete();
              });
              cubit.companyGetAllUsers();
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
                              NavigateTo(context: context, widget: const CompanyJobsScreen());
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
              body: cubit.companyGetAllUsersModel != null
                  ? LiquidPullToRefresh(
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
                                        cubit.companyGetSearchedUsers(search: searchController.text);
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
                                      decoration:
                                          BoxDecoration(color: myFavColor, borderRadius: BorderRadius.circular(4)
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
                                          NavigateTo(context: context, widget: const CompanyFilter());
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
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Most Popular",
                                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                            fontSize: 20.sp,
                                            color: myFavColor,
                                          ),
                                    ),
                                    SizedBox(
                                      height: size.height * 20 / size.height,
                                    ),
                                    ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) => buildCompanyHomeCard(
                                              context: context,
                                              index: index,
                                              model: cubit.companyGetAllUsersModel!,
                                              filePath: cubit.companyGetAllUsersModel!.data![index].cvUrl != null
                                                  ? cubit.companyGetAllUsersModel!.data![index].cvUrl!.split('/').last
                                                  : "null",
                                            ),
                                        separatorBuilder: (context, index) => const SizedBox(
                                              height: 12,
                                            ),
                                        itemCount: cubit.companyGetAllUsersModel!.data!.length),
                                  ],
                                ),
                              ),
                            if (searchController.text.isNotEmpty)
                              if (cubit.companyGetSearchedUsersModel != null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => buildCompanyHomeCard(
                                      context: context,
                                      index: index,
                                      model: cubit.companyGetSearchedUsersModel!,
                                      filePath: cubit.companyGetSearchedUsersModel!.data![index].cvUrl != null
                                          ? cubit.companyGetSearchedUsersModel!.data![index].cvUrl!.split('/').last
                                          : "null",
                                    ),
                                    separatorBuilder: (context, index) => const SizedBox(
                                      height: 12,
                                    ),
                                    itemCount: cubit.companyGetSearchedUsersModel!.data!.length,
                                  ),
                                ),
                            if (searchController.text.isNotEmpty)
                              if (cubit.companyGetSearchedUsersModel == null)
                                Center(child: CircularProgressIndicator(color: myFavColor)),
                            SizedBox(
                              height: size.height * 20 / size.height,
                            ),
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
      },
    );
  }

  Widget buildCompanyHomeCard({
    required int index,
    required String filePath,
    required BuildContext context,
    required CompanyGetAllUsersModel model,
  }) =>
      Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (model.data![index].pictureUrl != null)
                          GestureDetector(
                            onTap: () {
                              MainCubit.get(context).getUserWithId(userId: model.data![index].id!);
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: myFavColor3,
                              backgroundImage: NetworkImage(model.data![index].pictureUrl!),
                            ),
                          ),
                        if (model.data![index].pictureUrl == null)
                          GestureDetector(
                            onTap: () {
                              MainCubit.get(context).getUserWithId(userId: model.data![index].id!);
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: myFavColor3,
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: myFavColor4,
                              ),
                            ),
                          ),
                        const SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          width: 140,
                          child: GestureDetector(
                            onTap: () {
                              MainCubit.get(context).getUserWithId(userId: model.data![index].id!);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  model.data![index].displayName ?? "",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontSize: 14,
                                        color: myFavColor7,
                                      ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  model.data![index].bio ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: myFavColor6, fontSize: 14.sp),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Rate(
                                  iconSize: 10,
                                  color: const Color(0xFFFFAA01),
                                  allowHalf: true,
                                  allowClear: true,
                                  initialValue: roundToNearestHalf(model.data![index].averageRate!),
                                  readOnly: false,
                                  onChange: (value) {
                                    //cubit.rate = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.filePdf,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            final Uri toLaunch = Uri(
                              scheme: 'http',
                              host: 'mohamed2132-001-site1.ftempurl.com',
                              path: "/Documentaion/$filePath",
                            );
                            filePath != "null"
                                ? LayoutCompanyCubit.get(context).launchInBrowser(toLaunch)
                                : buildErrorToast(context: context, title: "Oops!", description: "No CV found!");
                          },
                          child: Text(
                            "Show CV",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 14.sp,
                                  color: myFavColor,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.location_pin,
                            color: myFavColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${model.data![index].city ?? ""}, ${model.data![index].country ?? ""}",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 14.sp,
                                  color: myFavColor7,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: myMaterialButton(
                        context: context,
                        onPressed: () {
                          NavigateTo(
                              context: context,
                              widget: MessageOfferScreen(
                                userId: model.data![index].id!,
                              ));
                        },
                        labelWidget: Text(
                          'Create Offer',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  double roundToNearestHalf(double number) {
    return (number * 2).round() / 2;
  }

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
    CompanyHomeCubit.get(context).companyGetSearchedUsers(search: searchController.text);
  }

  void _logEvent(String eventDescription) {
    if (logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      debugPrint('$eventTime $eventDescription');
    }
  }
}
