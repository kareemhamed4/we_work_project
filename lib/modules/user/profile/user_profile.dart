import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/modules/common/login/user_login.dart';
import 'package:we_work/modules/user/apply_job/cubit/cubit.dart';
import 'package:we_work/modules/user/apply_job/cubit/states.dart';
import 'package:we_work/modules/user/edit_profile/edit_profile_screen.dart';
import 'package:we_work/modules/user/profile/cubit/cubit.dart';
import 'package:we_work/modules/user/profile/cubit/states.dart';
import 'package:we_work/network/local/cache_helper.dart';
import 'package:we_work/shared/components/animated_progress_indicator.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class ExpansionItem {
  String headerText;
  String expandedText;
  bool isExpanded;
  IconData icon;

  ExpansionItem({
    required this.headerText,
    required this.expandedText,
    required this.icon,
    this.isExpanded = false,
  });
}

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final List<ExpansionItem> data = [
    ExpansionItem(
      headerText: "Name",
      expandedText: "",
      icon: FontAwesomeIcons.fileSignature,
    ),
    ExpansionItem(
      headerText: "CV",
      expandedText: "",
      icon: FontAwesomeIcons.filePdf,
    ),
    ExpansionItem(
      headerText: "Location",
      expandedText: "Country: \nCity: ",
      icon: FontAwesomeIcons.locationDot,
    ),
    ExpansionItem(
      headerText: "BIO",
      expandedText: "",
      icon: FontAwesomeIcons.circleInfo,
    ),
    ExpansionItem(
      headerText: "Education",
      expandedText: "",
      icon: FontAwesomeIcons.graduationCap,
    ),
    ExpansionItem(
      headerText: "Position",
      expandedText: "",
      icon: FontAwesomeIcons.checkToSlot,
    ),
    ExpansionItem(
      headerText: "JobType",
      expandedText: "",
      icon: FontAwesomeIcons.fontAwesome,
    ),
    ExpansionItem(
      headerText: "Email",
      expandedText: "",
      icon: FontAwesomeIcons.envelope,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserApplyJobCubit, UserApplyJobStates>(
      listener: (context, state) {
        if (state is UserUploadCVSuccessState) {
          Navigator.pop(context);
          UserProfileCubit.get(context).getUserInfo();
          buildSuccessToast(
            context: context,
            title: "Done",
            description: "CV Uploaded Successfully!",
          );
        }
        if (state is UserUploadCVErrorState) {
          buildSuccessToast(
            context: context,
            title: "Oops!",
            description: state.error,
          );
        }
        if (state is UserUploadCVLoadingState) {
          showProgressIndicator(context);
        }
      },
      builder: (context, state) {
        return BlocConsumer<UserProfileCubit, UserProfileStates>(
          listener: (context, state) {
            if (state is ProfileImageUploadSuccessState) {
              UserProfileCubit.get(context)
                  .userProfileModel!
                  .profilePictureUrl = state.imageUrl;
            }
          },
          builder: (context, state) {
            UserProfileCubit cubit = BlocProvider.of(context);
            data[0].expandedText = cubit.userProfileModel?.displayName ?? "";
            data[1].expandedText = cubit.userProfileModel?.cv != null
                ? cubit.userProfileModel?.cv!.split('/').last ?? ""
                : "";
            data[2].expandedText =
                "Country: ${cubit.userProfileModel?.country ?? ""}\nCity: ${cubit.userProfileModel?.city ?? ""}";
            data[3].expandedText = cubit.userProfileModel?.bio ?? "";
            data[4].expandedText = cubit.userProfileModel?.education ?? "";
            data[5].expandedText = cubit.userProfileModel?.position ?? "";
            data[6].expandedText = cubit.userProfileModel?.jobType ?? "";
            data[7].expandedText = cubit.userProfileModel?.email ?? "";
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'My Profile',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: myFavColor),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      NavigateTo(context: context, widget: EditProfileScreen());
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      color: myFavColor,
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (cubit.userProfileModel != null &&
                          cubit.userProfileModel!.profilePictureUrl != null)
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ConditionalBuilder(
                                condition:
                                    state is! ProfileUploadImageLoadingState,
                                builder: (context) => CircleAvatar(
                                  radius: 55,
                                  backgroundImage: NetworkImage(cubit
                                      .userProfileModel!.profilePictureUrl!),
                                ),
                                fallback: (context) => Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 55,
                                      backgroundImage: NetworkImage(cubit
                                          .userProfileModel!
                                          .profilePictureUrl!),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: CircularProgressIndicator(
                                        color: myFavColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.getProfileImage().then((value) {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 4.0, bottom: 4.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: myFavColor5,
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: myFavColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Center(
                                            child: FaIcon(
                                          FontAwesomeIcons.pen,
                                          color: myFavColor5,
                                          size: 10,
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (cubit.userProfileModel != null &&
                          cubit.userProfileModel!.profilePictureUrl == null)
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ConditionalBuilder(
                                condition:
                                    state is! ProfileUploadImageLoadingState,
                                builder: (context) => CircleAvatar(
                                  radius: 55,
                                  backgroundColor: myFavColor3,
                                  child: Center(
                                      child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: myFavColor4,
                                  )),
                                ),
                                fallback: (context) => Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 55,
                                      backgroundColor: myFavColor3,
                                      child: Center(
                                          child: Icon(
                                        Icons.image_not_supported_outlined,
                                        color: myFavColor4,
                                      )),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: CircularProgressIndicator(
                                        color: myFavColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.getProfileImage().then((value) {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 4.0, bottom: 4.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: myFavColor5,
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: myFavColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Center(
                                            child: FaIcon(
                                          FontAwesomeIcons.pen,
                                          color: myFavColor5,
                                          size: 10,
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (cubit.userProfileModel == null)
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ConditionalBuilder(
                                condition:
                                    state is! ProfileUploadImageLoadingState,
                                builder: (context) => CircleAvatar(
                                  radius: 55,
                                  backgroundColor: myFavColor3,
                                  child: Center(
                                      child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: myFavColor4,
                                  )),
                                ),
                                fallback: (context) => Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 55,
                                      backgroundColor: myFavColor3,
                                      child: Center(
                                          child: Icon(
                                        Icons.image_not_supported_outlined,
                                        color: myFavColor4,
                                      )),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: CircularProgressIndicator(
                                        color: myFavColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.getProfileImage().then((value) {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 4.0, bottom: 4.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: myFavColor5,
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: myFavColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Center(
                                            child: FaIcon(
                                          FontAwesomeIcons.pen,
                                          color: myFavColor5,
                                          size: 10,
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 15.h),
                      Text(
                        cubit.userProfileModel != null
                            ? cubit.userProfileModel!.displayName ?? ""
                            : "",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        cubit.userProfileModel != null
                            ? cubit.userProfileModel!.bio ?? ""
                            : "",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 19.h),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Complete your profile",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 16.sp),
                              ),
                              Text(
                                "(3/7)",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: myFavColor),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          const AnimatedLinearProgressIndicator(
                            percentage: 0.42,
                            label: "Profile",
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      if (cubit.userProfileModel != null)
                        ListView.builder(
                          key: UniqueKey(),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Card(
                                elevation: 0.5,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                  color: myFavColor7.withOpacity(0.4),
                                )),
                                child: ExpansionPanelList(
                                  elevation: 0,
                                  dividerColor: myFavColor7.withOpacity(0.5),
                                  expandedHeaderPadding: EdgeInsets
                                      .zero, // Removes the default header padding
                                  expansionCallback:
                                      (int panelIndex, bool isExpanded) {
                                    setState(() {
                                      data[index].isExpanded = !isExpanded;
                                    });
                                  },
                                  children: [
                                    ExpansionPanel(
                                      headerBuilder: (BuildContext context,
                                          bool isExpanded) {
                                        return ListTile(
                                          title: Text(
                                            data[index].headerText,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(fontSize: 16.sp),
                                          ),
                                          leading: FaIcon(
                                            data[index].icon,
                                            color: myFavColor.withOpacity(0.6),
                                          ),
                                        );
                                      },
                                      body: ListTile(
                                        title: GestureDetector(
                                          onTap: (){
                                            final Uri url = Uri.parse(cubit.userProfileModel!.cv!);
                                            index == 1
                                                ? LayoutCubit.get(context).launchInBrowser(url) :
                                            null;
                                          },
                                          child: Text(
                                            data[index].expandedText,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(fontSize: 16.sp,color: index == 1 ? Colors.blueAccent: myFavColor4,decoration: index == 1 ? TextDecoration.underline : TextDecoration.none),
                                          ),
                                        ),
                                        trailing: index == 1
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: myTextButton(
                                                    context: context,
                                                    label: "Edit",
                                                    onPressed: () {
                                                      UserApplyJobCubit.get(
                                                              context)
                                                          .uploadCVOnly();
                                                    }),
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                      isExpanded: data[index].isExpanded,
                                      canTapOnHeader: true,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      if (cubit.userProfileModel == null)
                        Center(
                            child: CircularProgressIndicator(
                          color: myFavColor,
                        )),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () {
                            CacheHelper.removeData(key: "userToken");
                            NavigateToReb(
                              context: context,
                              widget: LoginUser(),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            height: 60,
                            width: double.infinity,
                            child: Row(
                              children: const [
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.power_settings_new_rounded,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Flexible(
                                    child: SizedBox(
                                  width: double.infinity,
                                )),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
