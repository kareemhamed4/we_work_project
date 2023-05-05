import 'package:flutter/material.dart';
import 'package:we_work/shared/styles/colors.dart';

class AppliedJobScreen extends StatelessWidget {
  const AppliedJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Applied job',
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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      buildAppliedJobCard(size: size, context: context),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 23,
                      ),
                  itemCount: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppliedJobCard({
    required Size size,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: size.width * 392 / size.width,
        height: size.height * 195 / size.height,
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
                            height: 8,
                          ),
                          Text(
                            "UI,UX Designer",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 8,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "google@qwyu.com",
                                style:
                                    Theme.of(context).textTheme.caption!.copyWith(
                                          fontSize: 16,
                                          color: myFavColor.withOpacity(0.8),
                                        ),
                              ),
                              Text(
                                "Job Id:8",
                                style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                  fontSize: 16,
                                  color: myFavColor.withOpacity(0.8),
                                ),
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
}