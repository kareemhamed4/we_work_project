import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/modules/user/profile/cubit/cubit.dart';
import 'package:we_work/modules/user/profile/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController bioController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController educationController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController jobTypeController = TextEditingController();
    var model = UserProfileCubit.get(context).userProfileModel;
    bioController.text = model != null ? model.bio ?? bioController.text : " ";
    nameController.text =
        model != null ? model.displayName ?? nameController.text : " ";
    educationController.text = model != null ? model.education ?? educationController.text : " ";
    positionController.text = model != null ? model.position ?? positionController.text : " ";
    jobTypeController.text = model != null ? model.jobType ?? jobTypeController.text : " ";
    return BlocConsumer<UserProfileCubit, UserProfileStates>(
      listener: (context, state) {
        if (state is UserUpdateProfileSuccessState) {
          NavigateToReb(context: context, widget: const LayoutScreen());
          LayoutCubit.get(context).changeIndex(4);
          buildSuccessToast(
            title: "Done",
            context: context,
            description: state.msg,
          );
        }
        if (state is UserUpdateProfileErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        UserProfileCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Update Profile Info',
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      'Name',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Education',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: educationController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your education";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Bio',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your bio";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Position',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: positionController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your position";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'JobType',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: jobTypeController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your jobType";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 80.h),
                    ConditionalBuilder(
                      condition: state is! UserUpdateProfileLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.updateUserInfo(
                                name: nameController.text,
                                bio: bioController.text,
                                education: educationController.text,
                                position: positionController.text,
                                jobType: jobTypeController.text,
                            );
                          }
                        },
                        labelWidget: Text(
                          'Update',
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
                    SizedBox(height: 40.h),
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
