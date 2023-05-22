/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';
import '../upload_cv/apply_job_screen.dart';

class MicrosoftCompany extends StatelessWidget {
  const MicrosoftCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Company Details',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: myFavColor, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 76,
                width: 97,
                child: SvgPicture.asset(
                  "assets/image/microsoft.svg",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Microsoft",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.location_pin,
                    color: Color(0xff649344),
                  ),
                  Text(
                    "Alex , Egypt",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: myFavColor7.withOpacity(0.5),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: myMaterialButton(
                              context: context,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              isEnabled: false,
                              labelWidget: Text(
                                "Description",
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(color: myFavColor7),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 36,
                          ),
                          Expanded(
                            child: myMaterialButton(
                              context: context,
                              onPressed: () {},
                              labelWidget: Text(
                                "Company",
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "About Company",
                          style:
                          TextStyle(fontSize: 14, color: Color(0xff649344)),
                        ),
                      ),
                      const Text(
                        '''
Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,
''',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const Text(
                        "Since",
                        style:
                        TextStyle(fontSize: 14, color: Color(0xff649344)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "15-6-1999",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      const Text(
                        "Industry",
                        style:
                        TextStyle(fontSize: 14, color: Color(0xff649344)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "In marketing",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      const Text(
                        "Number of Employee",
                        style:
                        TextStyle(fontSize: 14, color: Color(0xff649344)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "120 employer",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              myMaterialButton(
                context: context,
                onPressed: () {
                  NavigateTo(
                      context: context, widget: const UploadCv());
                },
                labelWidget: Text(
                  'Apply Job',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
