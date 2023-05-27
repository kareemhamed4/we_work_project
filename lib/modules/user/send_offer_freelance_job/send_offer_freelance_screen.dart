import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/modules/user/offers/cubit/cubit.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class UserSendOfferToFreelanceJobScreen extends StatelessWidget {
  final int jobId;
  UserSendOfferToFreelanceJobScreen({Key? key, required this.jobId}) : super(key: key);
  TextEditingController offerDetailsController = TextEditingController();
  TextEditingController offerValueController = TextEditingController();
  TextEditingController timeToReceiveController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserHomeCubit, UserHomeStates>(
      listener: (context, state) {
        if (state is UserSendOfferToFreelanceJobSuccessState) {
          SystemChannels.textInput.invokeMethod('TextInput.hide').then((value) {
            UserOffersCubit.get(context).userGetOffers();
            NavigateToReb(context: context, widget: const LayoutScreen());
            LayoutCubit.get(context).changeIndex(0);
            buildSuccessToast(
                context: context, title: "Done", description: state.msg);
          });
        } else if (state is UserSendOfferToFreelanceJobErrorState) {
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
              'Offer',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: myFavColor),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your offer Details',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: myFavColor),
                    ),
                    SizedBox(height: 10.h),
                    buildFeedbackBox(
                      context: context,
                      minLines: 10,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your offer message";
                        }
                        return null;
                      },
                      hint: "Type your offer details here...",
                      messageController: offerDetailsController,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Your offer Value',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: myFavColor),
                    ),
                    SizedBox(height: 10.h),
                    myTextFormField(
                      context: context,
                      controller: offerValueController,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your offer value";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Your offer Value',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: myFavColor),
                    ),
                    SizedBox(height: 10.h),
                    myTextFormField(
                      context: context,
                      controller: timeToReceiveController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Time To Receive";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 80.h),
                    ConditionalBuilder(
                      condition: state is! UserSendOfferToFreelanceJobLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userSendOfferToFreelanceJob(
                              jobId: jobId,
                              offerDetails: offerDetailsController.text,
                              offerValue: offerValueController.text,
                              timeToRecieve: timeToReceiveController.text,
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
                    SizedBox(height: 18.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
