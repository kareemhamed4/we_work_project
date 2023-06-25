import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:we_work/cubit/cubit.dart';
import 'package:we_work/cubit/states.dart';
import 'package:we_work/models/user/user_get_offers_model.dart';
import 'package:we_work/modules/common/user_details/user_details_screen.dart';
import 'package:we_work/modules/user/offers/cubit/cubit.dart';
import 'package:we_work/modules/user/offers/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class OffersScreen extends StatelessWidget {
  OffersScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<MainCubit,MainStates>(
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
      builder: (context,state){
        return BlocConsumer<UserOffersCubit, UserOffersStates>(
          listener: (context, state) {
            if (state is UserDeclineOfferSuccessState) {
              buildSuccessToast(
                context: context,
                title: "Declined!",
                description: state.msg,
              );
            }
          },
          builder: (context, state) {
            UserOffersCubit cubit = BlocProvider.of(context);
            Future<void> handleRefresh() {
              final Completer<void> completer = Completer<void>();
              Timer(const Duration(seconds: 2), () {
                completer.complete();
              });
              cubit.userGetOffers();
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
                                cubit: cubit,
                                model: cubit.userGetOffersModel!,
                              ),
                              separatorBuilder: (context, index) => SizedBox(height: 16.h),
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
              ),
            );
          },
        );
      },
    );
  }

  Widget buildOffersCard({
    required Size size,
    required BuildContext context,
    required int index,
    required UserOffersCubit cubit,
    required List<UserGetOffersModel> model,
  }) =>
      Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: ((context) {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => AlertDialog(
                  scrollable: true,
                  icon: Icon(Icons.info_outline,color: myFavColor8),
                  title: const Text("Warning"),
                  content: const Text("Are you sure you want to Delete this received offer ?"),
                  actions: [
                    myMaterialButton(
                      context: context,
                      labelWidget: Text(
                        "Confirm",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                          color: myFavColor5,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        cubit.userDeclineOffer(offerId: model[index].id!);
                      },
                    ),
                    const SizedBox(height: 12),
                    myMaterialButton(
                      context: context,
                      bgColorForNotEnabled: myFavColor2,
                      isEnabled: false,
                      labelWidget: Text(
                        "Cancel",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                          color: myFavColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                  actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              );
            }),
            icon: Icons.close,
            foregroundColor: myFavColor8,
            label: "Decline",
          ),
        ]),
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: ((context) {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => AlertDialog(
                  scrollable: true,
                  icon: Icon(Icons.info_outline,color: myFavColor8),
                  title: const Text("Warning"),
                  content: const Text("Are you sure you want to Delete this received offer ?"),
                  actions: [
                    myMaterialButton(
                      context: context,
                      labelWidget: Text(
                        "Confirm",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                          color: myFavColor5,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        cubit.userDeclineOffer(offerId: model[index].id!);
                      },
                    ),
                    const SizedBox(height: 12),
                    myMaterialButton(
                      context: context,
                      bgColorForNotEnabled: myFavColor2,
                      isEnabled: false,
                      labelWidget: Text(
                        "Cancel",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                          color: myFavColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                  actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              );
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          MainCubit.get(context).getUserWithId(userId: model[index].sendrId!);
                        },
                        child: Row(
                          children: [
                            if (model[index].pictureUrl != null)
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: myFavColor3,
                                backgroundImage: NetworkImage(model[index].pictureUrl!),
                              ),
                            if (model[index].pictureUrl == null)
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: myFavColor3,
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: myFavColor4,
                                ),
                              ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              model[index].userName ?? "",
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 16,
                                    color: myFavColor7,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            model[index].offerdDate != null ? model[index].offerdDate!.substring(0, 10) : "",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 13.sp,
                                  color: myFavColor7,
                                ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60, right: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model[index].message ?? "",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14.sp),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            model[index].email ?? "",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 16.sp,
                                  color: myFavColor.withOpacity(0.8),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
