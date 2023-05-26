import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/layout_company/layout_screen.dart';
import 'package:we_work/modules/company/profile/cubit/cubit.dart';
import 'package:we_work/modules/company/profile/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class CompanyEditProfileScreen extends StatelessWidget {
  CompanyEditProfileScreen({super.key});
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController bioController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController educationController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController jobTypeController = TextEditingController();
    var model = CompanyProfileCubit.get(context).companyProfileModel;
    bioController.text = model != null ? model.bio ?? bioController.text : " ";
    nameController.text =
        model != null ? model.displayName ?? nameController.text : " ";
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CompanyProfileCubit, CompanyProfileStates>(
      listener: (context, state) {
        if (state is CompanyUpdateProfileSuccessState) {
          NavigateToReb(context: context, widget: const LayoutCompanyScreen());
          LayoutCubit.get(context).changeIndex(4);
          buildSuccessToast(
            title: "Done",
            context: context,
            description: state.msg,
          );
        }
        if (state is CompanyUpdateProfileErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        CompanyProfileCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Update Profile Info',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: myFavColor, fontSize: 20),
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
                    mySizedBox(size: size, myHeight: 8),
                    Text(
                      'Name',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size, myHeight: 8),
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
                    mySizedBox(size: size, myHeight: 20),
                    Text(
                      'Bio',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size, myHeight: 8),
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
                    mySizedBox(size: size, myHeight: 20),
                    mySizedBox(size: size, myHeight: 80),
                    ConditionalBuilder(
                      condition: state is! CompanyUpdateProfileLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.updateCompanyInfo(
                                name: nameController.text,
                                bio: bioController.text,
                                education: "null",
                                position: "null",
                                jobType: "null",
                            );
                          }
                        },
                        labelWidget: Text(
                          'Update',
                          style: Theme.of(context).textTheme.button,
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
                    mySizedBox(size: size, myHeight: 40),
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
