import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:we_work/modules/company/filter/cubit/cubit.dart';
import 'package:we_work/modules/company/filter/cubit/states.dart';
import 'package:we_work/modules/company/filtered_result/filtered_result_screen.dart';
import 'package:we_work/modules/company/home/cubit/cubit.dart';
import 'package:we_work/modules/company/home/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyFilter extends StatefulWidget {
  const CompanyFilter({super.key});
  @override
  State<CompanyFilter> createState() => _CompanyFilterState();
}

class _CompanyFilterState extends State<CompanyFilter> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyHomeCubit, CompanyHomeStates>(
      listener: (context, state) {
        if (state is CompanyGetAllUsersLoadingState) {
          showProgressIndicator(context);
        }
        if (state is CompanyGetAllUsersSuccessState) {
          Navigator.pop(context);
          NavigateTo(
              context: context,
              widget: CompanyFilteredResultScreen(
                companyGetFilteredUsersModel:
                    CompanyHomeCubit.get(context).companyGetFilteredUsersModel!,
              ));
        }
      },
      builder: (context, state) {
        return BlocConsumer<CompanyFilterUsersCubit, CompanyFilterUsersStates>(
          listener: (context, state) {},
          builder: (context, state) {
            CompanyFilterUsersCubit cubit = BlocProvider.of(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Filter',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: myFavColor),
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
                                .bodyMedium!
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
                                        .bodyMedium!
                                        .copyWith(
                                            color: myFavColor, fontSize: 16.sp),
                                  ),
                                  RadioGroup<String>.builder(
                                    fillColor: myFavColor,
                                    activeColor: myFavColor,
                                    groupValue: cubit.selectedCountry,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
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
                                        .copyWith(
                                            color: myFavColor, fontSize: 16.sp),
                                  ),
                                  RadioGroup<String>.builder(
                                    fillColor: myFavColor,
                                    activeColor: myFavColor,
                                    groupValue: cubit.selectedCity,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
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
                            "Job type",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
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
                                .bodyMedium!
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
                            "Experience",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
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
                                    .labelLarge!
                                    .copyWith(color: myFavColor),
                              ),
                              onPressed: () {
                                setState(() {
                                  cubit.selectedCity = "All";
                                  cubit.selectedCountry = "All";
                                  cubit.selectedExperience = "All";
                                  cubit.selectedJobType = "All";
                                  cubit.selectedPosition = "All";
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
                                CompanyHomeCubit.get(context)
                                    .companyGetAllUsers(
                                  city: cubit.selectedCity != "All"
                                      ? cubit.selectedCity
                                      : "",
                                  country: cubit.selectedCountry != "All"
                                      ? cubit.selectedCountry
                                      : "",
                                  position: cubit.selectedPosition != "All"
                                      ? cubit.selectedPosition
                                      : "",
                                  experience: cubit.selectedExperience != "All"
                                      ? cubit.selectedExperience
                                      : "",
                                  jobType: cubit.selectedJobType != "All"
                                      ? cubit.selectedJobType
                                      : "",
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
