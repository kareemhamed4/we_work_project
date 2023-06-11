import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:we_work/cubit/cubit.dart';
import 'package:we_work/cubit/states.dart';
import 'package:we_work/layout_company/cubit/cubit.dart';
import 'package:we_work/models/company/company_get_all_users_model.dart';
import 'package:we_work/modules/common/user_details/user_details_screen.dart';
import 'package:we_work/modules/company/filter/cubit/cubit.dart';
import 'package:we_work/modules/company/home/cubit/cubit.dart';
import 'package:we_work/modules/company/home/cubit/states.dart';
import 'package:we_work/modules/company/message_for_offer/message_for_offer_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class FilterationChoices {
  final String? country;
  final String? city;
  final String? position;
  final String? experience;
  final String? jobType;
  FilterationChoices({
    this.country,
    this.city,
    this.position,
    this.experience,
    this.jobType,
  });
}

class CompanyFilteredResultScreen extends StatefulWidget {
  final CompanyGetAllUsersModel companyGetFilteredUsersModel;
  const CompanyFilteredResultScreen({Key? key, required this.companyGetFilteredUsersModel}) : super(key: key);

  @override
  State<CompanyFilteredResultScreen> createState() => _CompanyFilteredResultScreenState();
}

class _CompanyFilteredResultScreenState extends State<CompanyFilteredResultScreen> {
  TextEditingController searchController = TextEditingController();
  var hasSpeech = false;
  SpeechToText speech = SpeechToText();
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  bool logEvents = false;
  @override
  Widget build(BuildContext context) {
    FilterationChoices filterationChoices = FilterationChoices(
      country: CompanyFilterUsersCubit.get(context).selectedCountry,
      city: CompanyFilterUsersCubit.get(context).selectedCity,
      position: CompanyFilterUsersCubit.get(context).selectedPosition,
      experience: CompanyFilterUsersCubit.get(context).selectedExperience,
      jobType: CompanyFilterUsersCubit.get(context).selectedJobType,
    );
    String filterChoice = '';
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is GetUserWithIdLoadingState) {
          showProgressIndicator(context);
        }
        if (state is GetUserWithIdSuccessState) {
          Navigator.pop(context);
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
                  preferredSize: Size.fromHeight(100.h),
                  child: Column(
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
                                  cubit.companyGetSearchedUsers(
                                    city: CompanyFilterUsersCubit.get(context).selectedCity != "All"
                                        ? CompanyFilterUsersCubit.get(context).selectedCity
                                        : "",
                                    country: CompanyFilterUsersCubit.get(context).selectedCountry != "All"
                                        ? CompanyFilterUsersCubit.get(context).selectedCountry
                                        : "",
                                    position: CompanyFilterUsersCubit.get(context).selectedPosition != "All"
                                        ? CompanyFilterUsersCubit.get(context).selectedPosition
                                        : "",
                                    experience: CompanyFilterUsersCubit.get(context).selectedExperience != "All"
                                        ? CompanyFilterUsersCubit.get(context).selectedExperience
                                        : "",
                                    jobType: CompanyFilterUsersCubit.get(context).selectedJobType != "All"
                                        ? CompanyFilterUsersCubit.get(context).selectedJobType
                                        : "",
                                    search: searchController.text,
                                  );
                                },
                                context: context,
                                hint: "Search",
                                suffixIcon: const Icon(Icons.search),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
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
                                    filterChoice = filterationChoices.experience ?? '';
                                    break;
                                  case 4:
                                    filterChoice = filterationChoices.jobType ?? '';
                                    break;
                                }
                                return filterChoice != "All"
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
                                                  .copyWith(fontSize: 14.sp, color: myFavColor5),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              },
                              separatorBuilder: (context, index) =>
                                  filterChoice != "All" ? const SizedBox(width: 15) : const SizedBox.shrink(),
                              itemCount: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: searchController.text.isEmpty
                    ? Column(
                        children: [
                          if (widget.companyGetFilteredUsersModel.data!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.companyGetFilteredUsersModel.data!.length,
                                itemBuilder: (context, index) => buildJobFilterationResultCard(
                                  context: context,
                                  index: index,
                                  model: widget.companyGetFilteredUsersModel,
                                  filePath: cubit.companyGetFilteredUsersModel!.data![index].cvUrl != null
                                      ? cubit.companyGetFilteredUsersModel!.data![index].cvUrl!.split('/').last
                                      : "null",
                                ),
                                separatorBuilder: (context, index) => const SizedBox(
                                  height: 10,
                                ),
                              ),
                            ),
                          if (widget.companyGetFilteredUsersModel.data!.isEmpty)
                            const Center(child: Text("No available Users regard your filteration")),
                        ],
                      )
                    : Column(
                        children: [
                          if (cubit.companyGetSearchedUsersModel != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cubit.companyGetSearchedUsersModel!.data!.length,
                                itemBuilder: (context, index) => buildJobFilterationResultCard(
                                  context: context,
                                  index: index,
                                  model: cubit.companyGetSearchedUsersModel!,
                                  filePath: cubit.companyGetFilteredUsersModel!.data![index].cvUrl != null
                                      ? cubit.companyGetFilteredUsersModel!.data![index].cvUrl!.split('/').last
                                      : "null",
                                ),
                                separatorBuilder: (context, index) => const SizedBox(
                                  height: 10,
                                ),
                              ),
                            ),
                          if (cubit.companyGetSearchedUsersModel == null)
                            const Center(child: Text("No available jobs regard search")),
                        ],
                      ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildJobFilterationResultCard({
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
                          width: 140.w,
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
                                        fontSize: 14.sp,
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
    CompanyHomeCubit.get(context).companyGetSearchedUsers(
      city: CompanyFilterUsersCubit.get(context).selectedCity != "All"
          ? CompanyFilterUsersCubit.get(context).selectedCity
          : "",
      country: CompanyFilterUsersCubit.get(context).selectedCountry != "All"
          ? CompanyFilterUsersCubit.get(context).selectedCountry
          : "",
      position: CompanyFilterUsersCubit.get(context).selectedPosition != "All"
          ? CompanyFilterUsersCubit.get(context).selectedPosition
          : "",
      experience: CompanyFilterUsersCubit.get(context).selectedExperience != "All"
          ? CompanyFilterUsersCubit.get(context).selectedExperience
          : "",
      jobType: CompanyFilterUsersCubit.get(context).selectedJobType != "All"
          ? CompanyFilterUsersCubit.get(context).selectedJobType
          : "",
      search: searchController.text,
    );
  }

  void _logEvent(String eventDescription) {
    if (logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      debugPrint('$eventTime $eventDescription');
    }
  }
}
