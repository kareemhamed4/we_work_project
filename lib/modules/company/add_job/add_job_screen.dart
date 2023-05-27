import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:we_work/layout_company/cubit/cubit.dart';
import 'package:we_work/modules/company/add_job/cubit/cubit.dart';
import 'package:we_work/modules/company/add_job/cubit/states.dart';
import 'package:we_work/modules/company/company_jobs/company_jobs_screen.dart';
import 'package:we_work/modules/company/home/cubit/cubit.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CompanyAddJobCubit,CompanyAddJobStates>(
      listener: (context,state){
        if(state is CompanyAddJobSuccessState){
          CompanyHomeCubit.get(context).companyGetHerJobs();
          Navigator.pop(context);
          Navigator.pop(context);
          NavigateTo(context: context, widget: const CompanyJobsScreen());
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
                      'Title',
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
                          .bodyMedium
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
                      'Requirement',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
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
                          .bodyMedium
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
                          .bodyMedium
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
                          .bodyMedium
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
                      'Salary',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
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
                      'Position',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CupertinoRadioChoice(
                      selectedColor: myFavColor,
                      notSelectedColor: myFavColor7,
                      choices: const {
                        'All': 'All',
                        'Senior': 'Senior',
                        'junior': 'junior',
                        'manager': 'manager',
                        'Leader': 'Leader'
                      },
                      onChange: (String selectedGender) {
                        setState(() {
                          cubit.selectedPosition = selectedGender;
                        });
                      },
                      initialKeyValue: 'All',
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Job Type',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CupertinoRadioChoice(
                      selectedColor: myFavColor,
                      notSelectedColor: myFavColor7,
                      choices: const {
                        'All': 'All',
                        'Full time': 'Full time',
                        'Part time': 'part time',
                        'Internship': 'Internship',
                        'Project based': 'Project based'
                      },
                      onChange: (String selectedGender) {
                        setState(() {
                          cubit.selectedJobType = selectedGender;
                        });
                      },
                      initialKeyValue: 'All',
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Experience',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RadioGroup<String>.builder(
                      fillColor: myFavColor,
                      activeColor: myFavColor,
                      groupValue: cubit.selectedExperience,
                      onChanged: (value) => setState(
                            () {
                          cubit.selectedExperience = value!;
                        },
                      ),
                      items: cubit.experienceList,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'Work place',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RadioGroup<String>.builder(
                      fillColor: const Color(0xff649344),
                      groupValue: cubit.selectedWorkPlace,
                      onChanged: (value) => setState(() {
                        cubit.selectedWorkPlace = value!;
                      }),
                      items: cubit.workPlaceList,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      'DisabledJob',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RadioGroup<String>.builder(
                      fillColor: myFavColor,
                      activeColor: myFavColor,
                      groupValue: cubit.selectedDisabledJobs,
                      onChanged: (value) => setState(
                            () {
                          cubit.selectedDisabledJobs = value!;
                        },
                      ),
                      items: cubit.disabledJobsList,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
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
                                position: cubit.selectedPosition != "All" ? cubit.selectedPosition : "",
                                jobType: cubit.selectedJobType != "All" ? cubit.selectedJobType : "",
                                requirement: requirementsController.text,
                                salary: salaryController.text,
                                city: cityController.text,
                                country: countryController.text,
                                experience: cubit.selectedExperience != "All" ? cubit.selectedExperience : "",
                                skill: skillsController.text,
                                workPlace: cubit.selectedWorkPlace != "All" ? cubit.selectedWorkPlace : "",
                                disabledJob: cubit.selectedDisabledJobs != "none" ? cubit.selectedDisabledJobs : "",
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
