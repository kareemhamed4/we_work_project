import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class OfferDetailsScreen extends StatefulWidget {
  const OfferDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  TextEditingController messageController = TextEditingController();
  String selectedOfferLevel = "Doing offer";
  List<String> offerLevel = [
    "Doing offer",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Details',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "Project Statue",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 16),
                ),
                leading: Image.asset("assets/icons/status.png"),
                trailing: const Text("Opened"),
              ),
              ListTile(
                title: Text(
                  "public time",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 16),
                ),
                leading: Image.asset("assets/icons/time.png"),
                trailing: const Text("from hour"),
              ),
              ListTile(
                title: Text(
                  "time to complete",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 16),
                ),
                leading: Image.asset("assets/icons/time.png"),
                trailing: const Text("One day"),
              ),
              ListTile(
                title: Text(
                  "Budget",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 16),
                ),
                leading: Image.asset("assets/icons/money.png"),
                trailing: const Text("200\$-100\$"),
              ),
              const SizedBox(
                height: 20,
              ),
              myDivider(),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Offers Level",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: myFavColor),
              ),
              const SizedBox(
                height: 8,
              ),
              RadioGroup<String>.builder(
                fillColor: myFavColor,
                activeColor: myFavColor,
                groupValue: selectedOfferLevel,
                onChanged: (value) => setState(
                  () {
                    selectedOfferLevel = value!;
                  },
                ),
                items: offerLevel,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              myDivider(),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Project Owner",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: myFavColor),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/image/microsoft.svg"),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Microsoft",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14,
                          color: myFavColor7,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              myDivider(),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Project Details",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: myFavColor),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 6,),
                  Text(
                    "learn more",
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14,color: myFavColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Required Skills",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: myFavColor),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Add Your offer",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: myFavColor),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time to received',
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            myTextFormField(
                              context: context,
                              type: TextInputType.text,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter time";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Offer value',
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            myTextFormField(
                              context: context,
                              type: TextInputType.text,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter Offer value";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Order Details",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: myFavColor7),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: size.height * 220/780,
                    child: buildFeedbackBox(
                        context: context,
                        hint: "",
                        messageController: messageController
                    ),
                  ),
                  const SizedBox(
                    height: 76,
                  ),
                  myMaterialButton(
                    context: context,
                    onPressed: (){},
                    labelWidget: Text(
                      'Send offer',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
