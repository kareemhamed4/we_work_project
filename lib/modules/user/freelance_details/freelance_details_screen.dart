import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/models/user/user_get_freelance_details_model.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class FreelanceDetailsScreen extends StatelessWidget {
  final UserGetFreelanceDetailsModel userGetFreelanceDetailsModel;
  final int id;
  final String pictureUrl;
  FreelanceDetailsScreen(
      {Key? key,
      required this.userGetFreelanceDetailsModel,
      required this.id,
      required this.pictureUrl})
      : super(key: key);

  TextEditingController timeToResieveController = TextEditingController();
  TextEditingController offerValueController = TextEditingController();
  TextEditingController offerDetailsController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String selectedOfferLevel = "Doing offer";
  List<String> offerLevel = [
    "Doing offer",
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserHomeCubit, UserHomeStates>(
      listener: (context, state) {
        if (state is UserSendOfferToFreelanceJobSuccessState) {
          SystemChannels.textInput.invokeMethod('TextInput.hide').then((value) {
            NavigateToReb(context: context, widget: const LayoutScreen());
            LayoutCubit.get(context).changeIndex(0);
            buildSuccessToast(
                context: context, title: "Done", description: state.msg);
          });
        }
        else if (state is UserSendOfferToFreelanceJobErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        UserHomeCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Project Details',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: myFavColor),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "Project Statue",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16.sp),
                    ),
                    leading: Image.asset("assets/icons/status.png"),
                    trailing: const Text("Opened"),
                  ),
                  ListTile(
                    title: Text(
                      "public time",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16.sp),
                    ),
                    leading: Image.asset("assets/icons/time.png"),
                    trailing:
                        Text(userGetFreelanceDetailsModel.timeToComplete ?? ""),
                  ),
                  ListTile(
                    title: Text(
                      "time to complete",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16.sp),
                    ),
                    leading: Image.asset("assets/icons/time.png"),
                    trailing: const Text("One day"),
                  ),
                  ListTile(
                    title: Text(
                      "Budget",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16.sp),
                    ),
                    leading: Image.asset("assets/icons/money.png"),
                    trailing: const Text("200\$-100\$"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Offers Level",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: myFavColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RadioGroup<String>.builder(
                    fillColor: myFavColor,
                    activeColor: myFavColor,
                    groupValue: selectedOfferLevel,
                    onChanged: (value) {},
                    items: offerLevel,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Project Owner",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: myFavColor),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      if (pictureUrl != "null")
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: myFavColor3,
                          backgroundImage: NetworkImage(pictureUrl),
                        ),
                      if (pictureUrl == "null")
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: myFavColor3,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: myFavColor4,
                          ),
                        ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        userGetFreelanceDetailsModel.projectOwner ?? "",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 14,
                              color: myFavColor7,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Project Details",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: myFavColor),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userGetFreelanceDetailsModel.projectDetails ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 16.sp),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "learn more",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 14.sp, color: myFavColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      myDivider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Required Skills",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: myFavColor),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        userGetFreelanceDetailsModel.requiredSkills ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 16.sp),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      myDivider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Your offer",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: myFavColor),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Time to received',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      myTextFormField(
                                        context: context,
                                        type: TextInputType.text,
                                        controller: timeToResieveController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter time";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Offer value',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      myTextFormField(
                                        context: context,
                                        controller: offerValueController,
                                        type: TextInputType.text,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter Offer value";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            myDivider(),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Offer Details",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: myFavColor7),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: size.height * 220 / 780,
                              child: buildFeedbackBox(
                                  context: context,
                                  hint: "",
                                  messageController: offerDetailsController),
                            ),
                            const SizedBox(
                              height: 76,
                            ),
                            ConditionalBuilder(
                              condition: state
                                  is! UserSendOfferToFreelanceJobLoadingState,
                              builder: (context) => myMaterialButton(
                                context: context,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userSendOfferToFreelanceJob(
                                      jobId: id,
                                      offerDetails: offerDetailsController.text,
                                      offerValue: offerValueController.text,
                                      timeToRecieve:
                                          timeToResieveController.text,
                                    );
                                  }
                                },
                                labelWidget: Text(
                                  'Send Offer',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                              fallback: (context) => myMaterialButton(
                                context: context,
                                onPressed: () {
                                  null;
                                },
                                labelWidget: const Center(
                                  child: SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
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
