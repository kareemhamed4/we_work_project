import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/shared/styles/colors.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    required this.salary,
    required this.location,
    this.jobDescription,
    required this.jobTitle,
    required this.index,
    this.height = 172,
    this.width = double.infinity,
    required this.imageLocation,
    this.fSize = 40,
    required this.pageTitle,
    this.isSaved = false,
  });
  String salary;
  String location;
  String imageLocation;
  String jobTitle;
  String? jobDescription;
  double height;
  double width;
  double fSize;
  String pageTitle;
  int index;
  bool isSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey.withOpacity(.1),
          ),
        ]),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 14, left: 14),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(imageLocation),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pageTitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 14,
                                          color: myFavColor7,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    jobTitle,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          FaIcon(
                            isSaved
                                ? FontAwesomeIcons.solidBookmark
                                : FontAwesomeIcons.bookmark,
                            color: myFavColor.withOpacity(0.5),
                            size: 20,
                          ),
                        ]),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      jobDescription ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "learn more",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 14, color: myFavColor),
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Color(0xff649344),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              location,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                        Text(
                          "$salary EG",
                          style: TextStyle(
                              fontSize: 18, color: Color(0xff649344)),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ));
  }
}
