import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_work/models/user/user_get_offers_model.dart';
import 'package:we_work/modules/user/offer_details/offer_details_screen.dart';
import 'package:we_work/modules/user/offers/cubit/cubit.dart';
import 'package:we_work/modules/user/offers/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserOffersCubit, UserOffersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserOffersCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Offers',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: myFavColor, fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                if (cubit.userGetOffersModel != null)
                  ConditionalBuilder(
                    condition: cubit.userGetOffersModel!.isNotEmpty,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildOffersCard(
                            size: size,
                            context: context,
                            index: index,
                            model: cubit.userGetOffersModel!),
                        separatorBuilder: (context, index) =>
                            mySizedBox(size: size, myHeight: 16),
                        itemCount: cubit.userGetOffersModel!.length,
                      ),
                    ),
                    fallback: (context) => const Center(child: Text("No Offers Found")),
                  ),
                if (cubit.userGetOffersModel == null)
                  Center(
                      child: CircularProgressIndicator(
                    color: myFavColor,
                  )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildOffersCard({
    required Size size,
    required BuildContext context,
    required int index,
    required List<UserGetOffersModel> model,
  }) =>
      GestureDetector(
        onTap: () {
          NavigateTo(
            context: context,
            widget: const OfferDetailsScreen(),
          );
        },
        child: Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/image/google.svg",
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            model[index].userName ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                              fontSize: 14,
                              color: myFavColor7,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            model[index].offerdDate != null
                                ? model[index]
                                .offerdDate!
                                .substring(0, 10)
                                : "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                              fontSize: 14,
                              color: myFavColor7,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60,right: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model[index].message ?? "",
                            style:
                            Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 16,
                              color: myFavColor7,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            model[index].email ?? "",
                            style:
                            Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 16,
                              color: myFavColor.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/image/google.svg",
                      ),
                      const SizedBox(
                        width: 26,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  model[index].userName ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: 14,
                                        color: myFavColor7,
                                      ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month_outlined),
                                    const SizedBox(
                                      width: 11,
                                    ),
                                    Text(
                                      model[index].offerdDate != null
                                          ? model[index]
                                              .offerdDate!
                                              .substring(0, 10)
                                          : "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 14,
                                            color: myFavColor7,
                                          ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              model[index].message ?? "",
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontSize: 16,
                                        color: myFavColor7,
                                      ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              model[index].email ?? "",
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontSize: 16,
                                        color: myFavColor.withOpacity(0.8),
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          ),
        ),
      );
}
