import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:rate/rate.dart';
import 'package:we_work/cubit/cubit.dart';
import 'package:we_work/cubit/states.dart';
import 'package:we_work/models/company/company_get_freelance_offers.dart';
import 'package:we_work/models/company/company_get_sent_offers_model.dart';
import 'package:we_work/modules/common/user_details/user_details_screen.dart';
import 'package:we_work/modules/company/offers/cubit/cubit.dart';
import 'package:we_work/modules/company/offers/cubit/states.dart';
import 'package:we_work/modules/company/send_accept/send_accept_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyOffersScreen extends StatelessWidget {
  CompanyOffersScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is GetUserWithIdLoadingState) {
          showProgressIndicator(context);
        }
        if (state is GetUserWithIdSuccessState) {
          Navigator.pop(context);
          NavigateTo(
              context: context,
              widget: UserDetailsScreen(isCompany: state.userProfileModel.dateOfCreation != null ? true : false));
        }
        if (state is GetUserWithIdErrorState) {
          Navigator.pop(context);
          buildErrorToast(context: context, title: "Oops!", description: state.error);
        }
      },
      builder: (context, state) {
        return BlocConsumer<CompanyOffersCubit, CompanyOffersStates>(
          listener: (context, state) {
            if (state is CompanyDeleteSentOfferSuccessState) {
              buildSuccessToast(
                title: "Done",
                context: context,
                description: "Applicant Deleted Successfully!",
              );
            }
            if (state is CompanyDeleteSentOfferErrorState) {
              buildSuccessToast(
                title: "Oops",
                context: context,
                description: "Applicant Deleted Failed!",
              );
            }
            if (state is CompanyRateUserLoadingState) {
              showProgressIndicator(context);
            }
            if (state is CompanyRateUserSuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
              buildSuccessToast(
                title: "Done",
                context: context,
                description: state.msg,
              );
            }
            if (state is CompanyRateUserErrorState) {
              buildSuccessToast(
                title: "Oops",
                context: context,
                description: state.error,
              );
            }
            if (state is CompanyDeclineFreelanceOfferSuccessState) {
              buildSuccessToast(
                context: context,
                title: "Declined!",
                description: state.msg,
              );
            }
          },
          builder: (context, state) {
            CompanyOffersCubit cubit = BlocProvider.of(context);
            Future<void> handleRefresh() {
              final Completer<void> completer = Completer<void>();
              Timer(const Duration(seconds: 2), () {
                completer.complete();
              });
              cubit.companyGetAllSentOffers();
              cubit.companyGetAllFreelanceOffers();
              return completer.future.then<void>((_) {
                ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
                  SnackBar(
                    content: const Text('Refresh complete'),
                    action: SnackBarAction(
                      label: 'RETRY',
                      textColor: myFavColor5,
                      onPressed: () {
                        _refreshIndicatorKey.currentState!.show();
                      },
                    ),
                  ),
                );
              });
            }

            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(
                  'Offers',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: myFavColor),
                ),
                centerTitle: true,
              ),
              body: LiquidPullToRefresh(
                key: _refreshIndicatorKey,
                onRefresh: handleRefresh,
                color: myFavColor,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        if (cubit.companyGetSentOffersModel != null)
                          if (cubit.companyGetSentOffersModel!.isNotEmpty)
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => buildAcceptedOffersCard(
                                  size: size, context: context, index: index, model: cubit.companyGetSentOffersModel!),
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 23,
                              ),
                              itemCount: cubit.companyGetSentOffersModel!.length,
                            ),
                        if (cubit.companyGetSentOffersModel != null)
                          if (cubit.companyGetSentOffersModel!.isEmpty)
                            const Center(child: Text("You haven't sent any offer yet.")),
                        if (cubit.companyGetSentOffersModel == null)
                          Center(
                              child: CircularProgressIndicator(
                            color: myFavColor,
                          )),
                        const SizedBox(
                          height: 35,
                        ),
                        Text(
                          'Freelancing offer',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: myFavColor),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        if (cubit.companyGetFreelanceOffersModel != null)
                          if (cubit.companyGetFreelanceOffersModel!.isNotEmpty)
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => buildFreelancingOffersCard(
                                  size: size,
                                  context: context,
                                  index: index,
                                  model: cubit.companyGetFreelanceOffersModel!,
                                  cubit: cubit,
                                  state: state),
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 23,
                              ),
                              itemCount: cubit.companyGetFreelanceOffersModel!.length,
                            ),
                        if (cubit.companyGetFreelanceOffersModel != null)
                          if (cubit.companyGetFreelanceOffersModel!.isEmpty)
                            const Center(child: Text("You don't receive any freelance offer until now")),
                        if (cubit.companyGetFreelanceOffersModel == null)
                          Center(
                              child: CircularProgressIndicator(
                            color: myFavColor,
                          )),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildAcceptedOffersCard({
    required Size size,
    required BuildContext context,
    required int index,
    required List<CompanyGetSentOffersModel> model,
  }) =>
      GestureDetector(
        onTap: () {},
        child: Slidable(
          startActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              onPressed: ((context) {
                context.read<CompanyOffersCubit>().companyDeleteSentOffer(offerId: model[index].offerId!);
              }),
              backgroundColor: myFavColor8,
              icon: Icons.delete_outline,
            ),
          ]),
          endActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              onPressed: ((context) {
                context.read<CompanyOffersCubit>().companyDeleteSentOffer(offerId: model[index].offerId!);
              }),
              backgroundColor: myFavColor8,
              icon: Icons.delete_outline,
            ),
          ]),
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: myFavColor6.withAlpha(20), spreadRadius: 2, blurRadius: 7, offset: const Offset(0, 0)),
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
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (model[index].pictureUrl != null)
                              GestureDetector(
                                onTap: () {
                                  MainCubit.get(context).getUserWithId(userId: model[index].reciverId!);
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: myFavColor3,
                                  backgroundImage: NetworkImage(model[index].pictureUrl!),
                                ),
                              ),
                            if (model[index].pictureUrl == null)
                              GestureDetector(
                                onTap: () {
                                  MainCubit.get(context).getUserWithId(userId: model[index].reciverId!);
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: myFavColor3,
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: myFavColor4,
                                  ),
                                ),
                              ),
                            const SizedBox(
                              width: 16,
                            ),
                            SizedBox(
                              width: 140.w,
                              child: GestureDetector(
                                onTap: () {
                                  MainCubit.get(context).getUserWithId(userId: model[index].reciverId!);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model[index].reciver ?? "",
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            fontSize: 14.sp,
                                            color: myFavColor7,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(model[index].bio ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: myFavColor6, fontSize: 14.sp)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month_outlined),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              model[index].offerdDate != null ? model[index].offerdDate!.substring(0, 10) : "",
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 14.sp,
                                    color: myFavColor7,
                                  ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model[index].message ?? "",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 16.sp,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildFreelancingOffersCard({
    required Size size,
    required BuildContext context,
    required int index,
    required List<CompanyGetFreelanceOffersModel> model,
    required CompanyOffersCubit cubit,
    required CompanyOffersStates state,
  }) =>
      Slidable(
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: ((context) {
              NavigateTo(
                  context: context,
                  widget: SendAcceptScreen(
                    userId: model[index].userId!,
                    isFreelance: true,
                  ));
            }),
            backgroundColor: myFavColor.withOpacity(0.7),
            icon: Icons.check,
          ),
        ]),
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: ((context) {
              buildRatingDialog(context: context, size: size, cubit: cubit, index: index, model: model, state: state);
            }),
            icon: Icons.star_rate_outlined,
            foregroundColor: const Color(0xFFFFAA01),
            label: "Rate",
          ),
          SlidableAction(
            onPressed: ((context) {
              cubit.companyDeclineFreelanceOffer(offerId: model[index].offerId!);
            }),
            icon: Icons.close,
            foregroundColor: myFavColor8,
            label: "Decline",
          ),
        ]),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: myFavColor6.withAlpha(20), spreadRadius: 2, blurRadius: 7, offset: const Offset(0, 0)),
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
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (model[index].pictureUrl != null)
                        GestureDetector(
                          onTap: () {
                            MainCubit.get(context).getUserWithId(userId: model[index].userId!);
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: myFavColor3,
                            backgroundImage: NetworkImage(model[index].pictureUrl!),
                          ),
                        ),
                      if (model[index].pictureUrl == null)
                        GestureDetector(
                          onTap: () {
                            MainCubit.get(context).getUserWithId(userId: model[index].userId!);
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: myFavColor3,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: myFavColor4,
                            ),
                          ),
                        ),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 140.w,
                              child: GestureDetector(
                                onTap: () {
                                  MainCubit.get(context).getUserWithId(userId: model[index].userId!);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model[index].displayName ?? "",
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            fontSize: 14.sp,
                                            color: myFavColor7,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      model[index].offerDetails ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: myFavColor6, fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_month_outlined),
                                  const SizedBox(
                                    width: 11,
                                  ),
                                  Text(
                                    model[index].dateTime != null ? model[index].dateTime!.substring(0, 10) : "",
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontSize: 14.sp,
                                          color: myFavColor7,
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/status.png"),
                          const SizedBox(
                            width: 6,
                          ),
                          Column(
                            children: [
                              Text(
                                "Offer Value",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 12.sp,
                                      color: myFavColor7,
                                    ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                model[index].offerValue != null ? model[index].offerValue.toString() : "",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 10.sp,
                                      color: myFavColor7,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset("assets/icons/time.png"),
                          const SizedBox(
                            width: 6,
                          ),
                          Column(
                            children: [
                              Text(
                                "Time to complete",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 12.sp,
                                      color: myFavColor7,
                                    ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                model[index].timeToComplete ?? "",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 10.sp,
                                      color: myFavColor7,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: myFavColor.withOpacity(0.7),
                            size: 22,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Column(
                            children: [
                              Text(
                                "About job",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 12.sp,
                                      color: myFavColor7,
                                    ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                model[index].title ?? "",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 10.sp,
                                      color: myFavColor7,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void buildRatingDialog({
    required BuildContext context,
    required Size size,
    required CompanyOffersCubit cubit,
    required List<CompanyGetFreelanceOffersModel> model,
    required int index,
    required CompanyOffersStates state,
  }) {
    showDialog<String>(
      context: context,
      builder: (dialogContext) => Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: size.width - 60,
            decoration: BoxDecoration(
              color: myFavColor5,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Text("Choose rate",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: myFavColor6, fontSize: 20)),
                  const SizedBox(
                    height: 20,
                  ),
                  Rate(
                    iconSize: 40,
                    color: const Color(0xFFFFAA01),
                    allowHalf: true,
                    allowClear: true,
                    initialValue: cubit.rate,
                    readOnly: false,
                    onChange: (value) {
                      cubit.rate = value;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ConditionalBuilder(
                    condition: state is! CompanyRateUserLoadingState,
                    builder: (context) => myMaterialButton(
                      context: context,
                      onPressed: () {
                        cubit.companyRateUser(userId: model[index].userId!, rate: cubit.rate.toInt());
                      },
                      labelWidget: Text("Submit",
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: myFavColor5, fontSize: 20)),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
