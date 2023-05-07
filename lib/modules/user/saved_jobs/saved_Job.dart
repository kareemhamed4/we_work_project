import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class SavedJob extends StatelessWidget {
  const SavedJob({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Applied Job',
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
            const SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.separated(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildSavedJobs(context: context,size: size),
                  separatorBuilder: (context, index) =>
                      mySizedBox(size: size, myHeight: 20),
                  itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSavedJobs({
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
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 27),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/image/google.svg"),
                    const SizedBox(
                      width: 26,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const SizedBox(height: 8,),
                        Text(
                          "UI,UX Designer",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
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
                    Text(
                      "Job Id:8",
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
              ],
            ),
          ),
        ),
      );
}
