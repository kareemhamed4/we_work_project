import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/layout_company/cubit/cubit.dart';
import 'package:we_work/modules/company/add_freelance_job/cubit/cubit.dart';
import 'package:we_work/modules/company/add_freelance_job/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class AddFreelanceJobScreen extends StatelessWidget {
  AddFreelanceJobScreen({super.key});
  TextEditingController titleController = TextEditingController();
  TextEditingController statueController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController timeToCompleteController = TextEditingController();
  TextEditingController projectDetailsController = TextEditingController();
  TextEditingController requiresSkillsController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CompanyAddFreelanceJobCubit, CompanyAddFreelanceJobStates>(
      listener: (context, state) {
        if (state is CompanyAddFreelanceJobSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          LayoutCompanyCubit.get(context).changeToggle();
          buildSuccessToast(
            context: context,
            title: "Done",
            description: state.msg,
          );
        }
        if (state is CompanyAddFreelanceJobErrorState) {
          Navigator.pop(context);
          Navigator.pop(context);
          buildErrorToast(
            context: context,
            title: "Oops!",
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        CompanyAddFreelanceJobCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Freelance job',
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
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: size.height * 30 / size.height,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Project title',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: titleController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Project title";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Project statue',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: statueController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Project statue";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Budget',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: budgetController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Budget";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Time to complete',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: timeToCompleteController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter time to complete";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'project details',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: projectDetailsController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter project details";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'requires skills',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: requiresSkillsController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter requires skills";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    ConditionalBuilder(
                      condition: state is! CompanyAddFreelanceJobLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.companyAddFreelanceJob(
                                projectStatus: statueController.text,
                                timeToComplete: timeToCompleteController.text,
                                projectDetails: projectDetailsController.text,
                                requiredSkills: requiresSkillsController.text,
                                budget: budgetController.text,
                                title: titleController.text,
                            );
                          }
                        },
                        labelWidget: Text(
                          'Confirm',
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
                    SizedBox(
                      height: size.height * 8 / size.height,
                    ),
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
