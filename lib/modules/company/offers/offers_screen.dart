import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:we_work/models/company/company_get_freelance_offers.dart';
import 'package:we_work/models/company/company_get_sent_offers_model.dart';
import 'package:we_work/modules/company/offers/cubit/cubit.dart';
import 'package:we_work/modules/company/offers/cubit/states.dart';
import 'package:we_work/modules/company/send_accept/send_accept_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyOffersScreen extends StatelessWidget {
  const CompanyOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      },
      builder: (context, state) {
        CompanyOffersCubit cubit = BlocProvider.of(context);
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
                        itemBuilder: (context, index) =>
                            buildAcceptedOffersCard(
                                size: size,
                                context: context,
                                index: index,
                                model: cubit.companyGetSentOffersModel!),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 23,
                        ),
                        itemCount: cubit.companyGetSentOffersModel!.length,
                      ),
                  if (cubit.companyGetSentOffersModel != null)
                    if (cubit.companyGetSentOffersModel!.isEmpty)
                      const Center(
                          child: Text("You haven't sent any offer yet.")),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: myFavColor),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  if (cubit.companyGetFreelanceOffersModel != null)
                    if (cubit.companyGetFreelanceOffersModel!.isNotEmpty)
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            buildFreelancingOffersCard(
                                size: size,
                                context: context,
                                index: index,
                                model: cubit.companyGetFreelanceOffersModel!),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 23,
                        ),
                        itemCount: cubit.companyGetFreelanceOffersModel!.length,
                      ),
                  if (cubit.companyGetFreelanceOffersModel != null)
                    if (cubit.companyGetFreelanceOffersModel!.isEmpty)
                      const Center(
                          child: Text(
                              "You don't receive any freelance offer until now")),
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
                context
                    .read<CompanyOffersCubit>()
                    .companyDeleteSentOffer(offerId: model[index].offerId!);
              }),
              backgroundColor: myFavColor8,
              icon: Icons.delete_outline,
            ),
          ]),
          endActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              onPressed: ((context) {
                context
                    .read<CompanyOffersCubit>()
                    .companyDeleteSentOffer(offerId: model[index].offerId!);
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 26),
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
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: myFavColor3,
                                backgroundImage:
                                    NetworkImage(model[index].pictureUrl!),
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
                              width: 16,
                            ),
                            SizedBox(
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model[index].reciver ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 14,
                                          color: myFavColor7,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(model[index].bio ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ],
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
                              model[index].offerdDate != null
                                  ? model[index].offerdDate!.substring(0, 10)
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
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model[index].message ?? "",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 16,
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
  }) =>
      Slidable(
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: ((context) {
              NavigateTo(context: context, widget: SendAcceptScreen(userId: model[index].userId!));
            }),
            backgroundColor: myFavColor.withOpacity(0.7),
            icon: Icons.check,
          ),
        ]),
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: ((context) {
              NavigateTo(context: context, widget: SendAcceptScreen(userId: model[index].userId!));
            }),
            backgroundColor: myFavColor.withOpacity(0.7),
            icon: Icons.check,
          ),
        ]),
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
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (model[index].pictureUrl != null)
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: myFavColor3,
                          backgroundImage:
                              NetworkImage(model[index].pictureUrl!),
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
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model[index].displayName ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 14,
                                          color: myFavColor7,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    model[index].offerDetails ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
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
                                    model[index].dateTime != null
                                        ? model[index]
                                            .dateTime!
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 12,
                                      color: myFavColor7,
                                    ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                model[index].offerValue != null
                                    ? model[index].offerValue.toString()
                                    : "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 10,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 12,
                                      color: myFavColor7,
                                    ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                model[index].timeToComplete ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 10,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 12,
                                      color: myFavColor7,
                                    ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                model[index].title ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 10,
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
}
