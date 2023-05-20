import 'package:flutter/material.dart';
import 'package:we_work/modules/company/message_for_offer/message_for_offer_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyOffersScreen extends StatelessWidget {
  const CompanyOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      buildAcceptedOffersCard(size: size, context: context),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 23,
                      ),
                  itemCount: 2),
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
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    buildFreelancingOffersCard(size: size, context: context),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 23,
                ),
                itemCount: 1,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildAcceptedOffersCard({
    required Size size,
    required BuildContext context,
  }) =>
      GestureDetector(
        onTap: () {
          /*NavigateTo(
            context: context,
            widget: const MessageOfferScreen(),
          );*/
        },
        child: Container(
          height: size.height * 165 / size.height,
          width: size.width * 392 / size.width,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/image/person.png"),
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
                                  "Manar Maher",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                    fontSize: 14,
                                    color: myFavColor7,
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
                                        "13 dec 2022",
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
                            Text("UI, UX Designer",
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              "manar applied for a job as  ui ux designer",
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
                ],
              ),
            ),
          ),
        ),
      );


  Widget buildFreelancingOffersCard({
    required Size size,
    required BuildContext context,
  }) =>
      GestureDetector(

        child: Container(
          height: size.height * 200 / size.height,
          width: size.width * 392 / size.width,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/image/person.png"),
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
                                  "Manar Maher",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                    fontSize: 14,
                                    color: myFavColor7,
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
                                        "13 dec 2022",
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
                            Text("UI, UX Designer",
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              "manar applied for a job as  ui ux designer",
                              style:
                              Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/icons/status.png"),
                                    Text(
                                      "Project statue",
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
                                Row(
                                  children: [
                                    Image.asset("assets/icons/time.png"),
                                    Text(
                                      "Time to complete",
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
                          ],
                        ),
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
