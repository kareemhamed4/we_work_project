import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_work/modules/user/offer_details/offer_details_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

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
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildOffersCard(size: size, context: context),
                separatorBuilder: (context, index) =>
                    mySizedBox(size: size, myHeight: 16),
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOffersCard({
    required Size size,
    required BuildContext context,
  }) =>
      Container(
        height: size.height * 190 / size.height,
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 27),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
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
                                "Google",
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
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            "manar applied for a job as ui ux designer",
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
                            "google@qwyu.com",
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
                ),
              ],
            ),
          ),
        ),
      );
}
