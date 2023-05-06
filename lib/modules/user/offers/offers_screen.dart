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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      buildOffersCard(size: size, context: context),
                  separatorBuilder: (context, index) => mySizedBox(size: size,myHeight: 23),
                  itemCount: 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOffersCard({
    required Size size,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: (){
        NavigateTo(
            context: context,
            widget: const OfferDetailsScreen(),
        );
      },
      child: SizedBox(
        width: size.width * 392 / size.width,
        height: size.height * 190 / size.height,
        child: Card(
          margin: EdgeInsets.zero,
          color: myFavColor5,
          elevation: 2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                  fontSize: 16,
                                  color: myFavColor7,
                                ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            "google@qwyu.com",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
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
      ),
    );
  }
}
