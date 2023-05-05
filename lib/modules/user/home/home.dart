import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:we_work/modules/user/filter/filter.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/components/custom_card.dart';
import 'package:we_work/shared/styles/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: searchController.text.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 6),
                child: IconButton(
                  icon: Icon(
                    Icons.sort_outlined,
                    color: myFavColor6,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      ZoomDrawer.of(context)?.open();
                    });
                  },
                ),
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    searchController.clear();
                  });
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: myFavColor,
                ),
              ),
        title: searchController.text.isEmpty
            ? const SizedBox.shrink()
            : Text(
                'Search result',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: myFavColor, fontSize: 20),
              ),
        centerTitle: true,
        actions: [
          searchController.text.isEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: myFavColor7,
                          blurRadius: 2, // adjust the blur radius here
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/image/Frame 34.png",
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: myTextFormField(
                      controller: searchController,
                      onChange: (value) {
                        setState(() {
                          searchController.text = value;
                        });
                      },
                      context: context,
                      hint: "Search",
                      suffixIcon: const Icon(Icons.search),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          color: myFavColor,
                          borderRadius: BorderRadius.circular(4)
                          //more than 50% of width makes circle
                          ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 25,
                        ),
                        color: Colors.black,
                        onPressed: () {
                          NavigateTo(context: context, widget: const Filter());
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 20 / size.height,
              ),
              if (searchController.text.isEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Available Jobs",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 20,
                            color: myFavColor,
                          ),
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    CustomCard(
                      index: 0,
                      pageTitle: 'Google',
                      imageLocation: "assets/image/google.svg",
                      jobTitle: 'Flutter Developer',
                      jobDescription:
                          '  Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      salary: "500",
                      location: 'Alex , EGYPT',
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    Text(
                      "Freelancing Jobs",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 20,
                            color: myFavColor,
                          ),
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    CustomCard(
                      index: 1,
                      pageTitle: 'Microsoft',
                      imageLocation: "assets/image/microsoft.svg",
                      jobTitle: 'Frontend Developer',
                      jobDescription:
                          '  Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      salary: "300",
                      location: 'Remotely, from house',
                    ),
                  ],
                ),
              if (searchController.text.isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CustomCard(
                    index: 0,
                    pageTitle: 'Google',
                    imageLocation: "assets/image/google.svg",
                    jobTitle: 'Flutter Developer',
                    jobDescription:
                        '  Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    salary: "500",
                    location: 'Alex , EGYPT',
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: 3,
                )
            ],
          ),
        ),
      ),
    );
  }
}
