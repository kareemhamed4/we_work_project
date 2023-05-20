import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/layout_company/cubit/cubit.dart';
import 'package:we_work/modules/company/add_job/cubit/cubit.dart';
import 'package:we_work/modules/company/add_job/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class AddJobScreen extends StatelessWidget {
  AddJobScreen({super.key});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController jobTypeController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController workPlaceController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController disabledJobController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CompanyAddJobCubit,CompanyAddJobStates>(
      listener: (context,state){
        if(state is CompanyAddJobSuccessState){
          Navigator.pop(context);
          Navigator.pop(context);
          LayoutCompanyCubit.get(context).changeToggle();
          buildSuccessToast(
              context: context,
              title: "Done",
              description: state.msg,
          );
        }
        if(state is CompanyAddJobErrorState){
          Navigator.pop(context);
          Navigator.pop(context);
          buildErrorToast(
            context: context,
            title: "Oops!",
            description: state.error,
          );
        }
      },
      builder: (context,state){
        CompanyAddJobCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Job',
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
                      'Title',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
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
                          return "Please enter job title";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Description',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: descriptionController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter job description";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'position',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: positionController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter job position";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Job Type',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: jobTypeController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter job type";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Requirement',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: requirementsController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter job requirements";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'City',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: cityController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the city";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Country',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: countryController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the country";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Skills',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: skillsController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter required skills";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Experience',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: experienceController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter job Experience";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Salary',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: salaryController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the salary";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Work place',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: workPlaceController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter job work place";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'DisabledJob',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    myTextFormField(
                      context: context,
                      controller: disabledJobController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter disabledJob";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    ConditionalBuilder(
                      condition: state is! CompanyAddJobLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.companyAddJob(
                                title: titleController.text,
                                description: descriptionController.text,
                                position: positionController.text,
                                jobType: jobTypeController.text,
                                requirement: requirementsController.text,
                                salary: salaryController.text,
                                city: cityController.text,
                                country: countryController.text,
                                experience: experienceController.text,
                                skill: skillsController.text,
                                workPlace: workPlaceController.text,
                                disabledJob: disabledJobController.text,
                            );
                          }
                        },
                        labelWidget: Text(
                          'Confirm',
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
