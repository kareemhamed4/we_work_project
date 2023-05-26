import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/modules/common/choose_signup/selection_sign_up.dart';
import 'package:we_work/modules/company/edit_profile/edit_profile_screen.dart';
import 'package:we_work/modules/company/profile/cubit/cubit.dart';
import 'package:we_work/modules/company/profile/cubit/states.dart';
import 'package:we_work/network/local/cache_helper.dart';
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

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  final List<ExpansionItem> data = [
    ExpansionItem(
      headerText: "Name",
      expandedText: "",
      icon: FontAwesomeIcons.fileSignature,
    ),
    ExpansionItem(
      headerText: "Location",
      expandedText: "Country: \nCity: ",
      icon: FontAwesomeIcons.locationDot,
    ),
    ExpansionItem(
      headerText: "Email",
      expandedText: "",
      icon: FontAwesomeIcons.envelope,
    ),
    ExpansionItem(
      headerText: "BIO",
      expandedText: "",
      icon: FontAwesomeIcons.circleInfo,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyProfileCubit,CompanyProfileStates>(
      listener: (context,state){
        if(state is ProfileImageUploadSuccessState){
          CompanyProfileCubit.get(context).companyProfileModel!.profilePictureUrl = state.imageUrl;
        }
      },
      builder: (context,state){
        CompanyProfileCubit cubit = BlocProvider.of(context);
        data[0].expandedText = cubit.companyProfileModel?.displayName ?? "";
        data[1].expandedText =
        "Country: ${cubit.companyProfileModel?.country ?? ""}\nCity: ${cubit.companyProfileModel?.city ?? ""}";
        data[2].expandedText = cubit.companyProfileModel?.email ?? "";
        data[3].expandedText = cubit.companyProfileModel?.bio ?? "";
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  NavigateTo(context: context, widget: CompanyEditProfileScreen());
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
                  if (cubit.companyProfileModel != null &&
                      cubit.companyProfileModel!.profilePictureUrl != null)
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ConditionalBuilder(
                            condition: state is! ProfileUploadImageLoadingState,
                            builder: (context) => CircleAvatar(
                              radius: 55,
                              backgroundImage: NetworkImage(
                                  cubit.companyProfileModel!.profilePictureUrl!),
                            ),
                            fallback: (context) => Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  backgroundImage: NetworkImage(cubit
                                      .companyProfileModel!.profilePictureUrl!),
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
                  if (cubit.companyProfileModel != null && cubit.companyProfileModel!.profilePictureUrl == null)
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ConditionalBuilder(
                            condition: state is! ProfileUploadImageLoadingState,
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
                  if (cubit.companyProfileModel == null)
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ConditionalBuilder(
                            condition: state is! ProfileUploadImageLoadingState,
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
                  const SizedBox(height: 15),
                  Text(
                    cubit.companyProfileModel != null
                        ? cubit.companyProfileModel!.displayName ?? ""
                        : "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 34),
                  ListView.builder(
                    key: UniqueKey(),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0), // Adjust the bottom padding as needed
                        child: Card(
                          elevation: 0.5,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: myFavColor7.withOpacity(0.4),
                              )
                          ),
                          child: ExpansionPanelList(
                            elevation: 0,
                            dividerColor: myFavColor7.withOpacity(0.5),
                            expandedHeaderPadding: EdgeInsets.zero, // Removes the default header padding
                            expansionCallback: (int panelIndex, bool isExpanded) {
                              setState(() {
                                data[index].isExpanded = !isExpanded;
                              });
                            },
                            children: [
                              ExpansionPanel(
                                headerBuilder: (BuildContext context, bool isExpanded) {
                                  return ListTile(
                                    title: Text(data[index].headerText,style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),),
                                    leading: FaIcon(data[index].icon,color: myFavColor.withOpacity(0.6),),
                                  );
                                },
                                body: ListTile(
                                  title: Text(data[index].expandedText,style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),),
                                ),
                                isExpanded: data[index].isExpanded,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        CacheHelper.removeData(key: "companyToken");
                        NavigateToReb(
                          context: context,
                          widget: const ChooseRegister(),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
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
  }
}
