import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:we_work/modules/user/filter/cubit/cubit.dart';
import 'package:we_work/modules/user/filter/cubit/states.dart';
import 'package:we_work/modules/user/filtered_result/filtered_result_screen.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class UserFilterScreen extends StatefulWidget {
  const UserFilterScreen({super.key});
  @override
  State<UserFilterScreen> createState() => _UserFilterScreenState();
}

class _UserFilterScreenState extends State<UserFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserHomeCubit, UserHomeStates>(
      listener: (context, state) {
        if (state is UserGetAllJobsLoadingState) {
          showProgressIndicator(context);
        }
        if (state is UserGetAllJobsSuccessState) {
          Navigator.pop(context);
          NavigateTo(
            context: context,
            widget: FilteredResultScreen(
              userGetFilteredJobs: UserHomeCubit.get(context).userGetFilterJobsModel!,
            ),
          );
        }
      },
      builder: (context, state) {
        return BlocConsumer<UserFilterJobsCubit, UserFilterJobsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            UserFilterJobsCubit cubit = BlocProvider.of(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Filter',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: myFavColor),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpansionTile(
                      title: Text(
                        "Location",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: myFavColor),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Country",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: myFavColor, fontSize: 16.sp),
                                    ),
                                    RadioGroup<String>.builder(
                                      fillColor: myFavColor,
                                      activeColor: myFavColor,
                                      groupValue: cubit.selectedCountry,
                                      textStyle: Theme.of(context).textTheme.bodyMedium,
                                      onChanged: (value) => setState(() {
                                        cubit.selectedCountry = value!;
                                      }),
                                      items: cubit.countriesList,
                                      itemBuilder: (item) => RadioButtonBuilder(
                                        item,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(flex: 1, child: SizedBox()),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "City",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: myFavColor, fontSize: 16.sp),
                                    ),
                                    RadioGroup<String>.builder(
                                      fillColor: myFavColor,
                                      activeColor: myFavColor,
                                      groupValue: cubit.selectedCity,
                                      textStyle: Theme.of(context).textTheme.bodyMedium,
                                      onChanged: (value) => setState(() {
                                        cubit.selectedCity = value!;
                                      }),
                                      items: cubit.citiesList,
                                      itemBuilder: (item) => RadioButtonBuilder(
                                        item,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        "Type of workplace",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: myFavColor),
                      ),
                      children: [
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
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        "Job type",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: myFavColor),
                      ),
                      children: [
                        const SizedBox(
                          height: 20,
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
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        "Position level",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: myFavColor),
                      ),
                      children: [
                        const SizedBox(
                          height: 20,
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
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        "Salary",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: myFavColor),
                      ),
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        SfRangeSlider(
                          inactiveColor: myFavColor3,
                          activeColor: myFavColor,
                          min: 0,
                          max: 30000,
                          onChangeStart: (value) {
                            setState(() {
                              cubit.selectedMinSalary = value.start;
                              cubit.selectedMaxSalary = value.end;
                            });
                          },
                          onChangeEnd: (value) {
                            setState(() {
                              cubit.selectedMinSalary = value.start;
                              cubit.selectedMaxSalary = value.end;
                            });
                          },
                          stepSize: 500,
                          enableIntervalSelection: true,
                          showDividers: false,
                          values: cubit.valuesOfPrice,
                          interval: 40,
                          showTicks: false,
                          showLabels: false,
                          enableTooltip: true,
                          minorTicksPerInterval: 1,
                          onChanged: (SfRangeValues values) {
                            setState(() {
                              cubit.valuesOfPrice = values;
                            });
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        "Experience",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: myFavColor),
                      ),
                      children: [
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
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        "DisabledJob",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: myFavColor),
                      ),
                      children: [
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
                      ],
                    ),
                    SizedBox(height: 100.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: myMaterialButton(
                              context: context,
                              bgColorForNotEnabled: myFavColor2,
                              isEnabled: false,
                              labelWidget: Text(
                                "Reset",
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: myFavColor),
                              ),
                              onPressed: () {
                                setState(() {
                                  cubit.selectedCity = "All";
                                  cubit.selectedCountry = "All";
                                  cubit.selectedExperience = "All";
                                  cubit.selectedJobType = "All";
                                  cubit.selectedMaxSalary = 30000;
                                  cubit.selectedMinSalary = 0;
                                  cubit.selectedPosition = "All";
                                  cubit.selectedWorkPlace = "All";
                                  cubit.selectedDisabledJobs = "none";
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 36,
                          ),
                          Expanded(
                            flex: 2,
                            child: myMaterialButton(
                              context: context,
                              onPressed: () {
                                UserHomeCubit.get(context).userGetAllJob(
                                  city: cubit.selectedCity != "All" ? cubit.selectedCity : "",
                                  country: cubit.selectedCountry != "All" ? cubit.selectedCountry : "",
                                  position: cubit.selectedPosition != "All" ? cubit.selectedPosition : "",
                                  experience: cubit.selectedExperience != "All" ? cubit.selectedExperience : "",
                                  jobType: cubit.selectedJobType != "All" ? cubit.selectedJobType : "",
                                  salaryMin: cubit.selectedMinSalary!.toInt(),
                                  salaryMax: cubit.selectedMaxSalary!.toInt(),
                                  disabled: cubit.selectedDisabledJobs != "none" ? cubit.selectedDisabledJobs : "",
                                );
                              },
                              labelWidget: Text(
                                "Apply",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
