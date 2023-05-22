import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/models/company/company_get_all_users_model.dart';
import 'package:we_work/modules/company/filter/cubit/cubit.dart';
import 'package:we_work/modules/company/home/cubit/cubit.dart';
import 'package:we_work/modules/company/home/cubit/states.dart';
import 'package:we_work/modules/company/message_for_offer/message_for_offer_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class FilterationChoices {
  final String? country;
  final String? city;
  final String? position;
  final String? experience;
  final String? jobType;
  FilterationChoices({
    this.country,
    this.city,
    this.position,
    this.experience,
    this.jobType,
  });
}

class CompanyFilteredResultScreen extends StatelessWidget {
  final CompanyGetAllUsersModel companyGetFilteredUsersModel;
  const CompanyFilteredResultScreen(
      {Key? key, required this.companyGetFilteredUsersModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilterationChoices filterationChoices = FilterationChoices(
      country: CompanyFilterUsersCubit.get(context).selectedCountry,
      city: CompanyFilterUsersCubit.get(context).selectedCity,
      position: CompanyFilterUsersCubit.get(context).selectedPosition,
      experience: CompanyFilterUsersCubit.get(context).selectedExperience,
      jobType: CompanyFilterUsersCubit.get(context).selectedJobType,
    );
    String filterChoice = '';
    return BlocConsumer<CompanyHomeCubit, CompanyHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CompanyHomeCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Filteration Result',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: myFavColor,
                    fontSize: 20,
                  ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 40,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            filterChoice = filterationChoices.country ?? '';
                            break;
                          case 1:
                            filterChoice = filterationChoices.city ?? '';
                            break;
                          case 2:
                            filterChoice = filterationChoices.position ?? '';
                            break;
                          case 3:
                            filterChoice = filterationChoices.experience ?? '';
                            break;
                          case 4:
                            filterChoice = filterationChoices.jobType ?? '';
                            break;
                        }
                        return filterChoice != "All"
                            ? Container(
                                decoration: BoxDecoration(
                                  color: myFavColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      filterChoice,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              fontSize: 14, color: myFavColor5),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                      separatorBuilder: (context, index) =>
                          filterChoice != "All"
                              ? const SizedBox(width: 15)
                              : const SizedBox.shrink(),
                      itemCount: 5,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                if (companyGetFilteredUsersModel.data!.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: companyGetFilteredUsersModel.data!.length,
                      itemBuilder: (context, index) => buildJobFilterationResultCard(
                        context: context,
                        index: index,
                        model: companyGetFilteredUsersModel,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                    ),
                  ),
                if (companyGetFilteredUsersModel.data!.isEmpty)
                  const Center(
                      child: Text("No available Users regard your filteration")),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget buildJobFilterationResultCard({
    required int index,
    required BuildContext context,
    required CompanyGetAllUsersModel model,
  }) =>
      Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: myFavColor6.withAlpha(20),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 0)),
          ],
        ),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          color: myFavColor5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/image/person.png"),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              model.data![index].displayName ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                fontSize: 14,
                                color: myFavColor7,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              model.data![index].bio ?? "",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.filePdf,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Show CV",
                          style:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                            color: myFavColor,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.location_pin,
                            color: myFavColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${model.data![index].city ?? ""}, ${model.data![index].country ?? ""}",
                            style:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                              color: myFavColor7,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: myMaterialButton(
                        context: context,
                        onPressed: () {
                          NavigateTo(
                              context: context,
                              widget: MessageOfferScreen(
                                userId: model.data![index].id!,
                              ));
                        },
                        labelWidget: Text(
                          'Create Offer',
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
}
