import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:we_work/modules/user/filter/cubit/cubit.dart';
import 'package:we_work/modules/user/filter/cubit/states.dart';
import 'package:we_work/modules/user/filtered_result/filtered_result_screen.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});
  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
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
                userGetFilteredJobs:
                    UserHomeCubit.get(context).userGetFilterJobsModel!,
              ));
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
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: myFavColor, fontSize: 20),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Location",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: myFavColor),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: myFavColor7,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
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
                                        .bodyText2!
                                        .copyWith(
                                            color: myFavColor, fontSize: 16),
                                  ),
                                  RadioGroup<String>.builder(
                                    fillColor: myFavColor,
                                    activeColor: myFavColor,
                                    groupValue: cubit.selectedCountry,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontSize: 14),
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
                                        .bodyText2!
                                        .copyWith(
                                            color: myFavColor, fontSize: 16),
                                  ),
                                  RadioGroup<String>.builder(
                                    fillColor: myFavColor,
                                    activeColor: myFavColor,
                                    groupValue: cubit.selectedCity,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontSize: 14),
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
                      const SizedBox(
                        height: 25,
                      ),
                      myDivider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Type of workplace",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: myFavColor),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: myFavColor7,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
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
                      myDivider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Job type",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: myFavColor),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: myFavColor7,
                          ),
                        ],
                      ),
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
                      myDivider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Position level",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: myFavColor),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: myFavColor7,
                          ),
                        ],
                      ),
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
                      myDivider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Salary",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: myFavColor),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: myFavColor7,
                          ),
                        ],
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
                      const SizedBox(
                        height: 20,
                      ),
                      myDivider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Experience",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: myFavColor),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: myFavColor7,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
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
                      const SizedBox(
                        height: 20,
                      ),
                      myDivider(),
                      const SizedBox(
                        height: 20,
                      ),
                      /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Interested",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: myFavColor),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: myFavColor7,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories['responseTotalResult'],
                    itemBuilder: (BuildContext context, int index) =>
                        buildCheckBox(index: index),
                  ),
                  const SizedBox(
                    height: 20,
                  ),*/
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: myMaterialButton(
                              context: context,
                              bgColorForNotEnabled: myFavColor2,
                              isEnabled: false,
                              labelWidget: Text(
                                "Reset",
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(color: myFavColor),
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
                                  country: cubit.selectedCountry != "All" ? cubit.selectedCountry :"",
                                  position: cubit.selectedPosition != "All" ? cubit.selectedPosition :"",
                                  experience: cubit.selectedExperience != "All" ? cubit.selectedExperience :"",
                                  jobType: cubit.selectedJobType != "All" ? cubit.selectedJobType :"",
                                  salaryMin: cubit.selectedMinSalary!.toInt(),
                                  salaryMax: cubit.selectedMaxSalary!.toInt(),
                                );
                              },
                              labelWidget: Text(
                                "Apply",
                                style: Theme.of(context).textTheme.button,
                              ),
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
      },
    );
  }
}
