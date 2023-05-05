import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:we_work/modules/company/filter/filter_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
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
        physics: const BouncingScrollPhysics(),
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
                          NavigateTo(context: context, widget: const CompanyFilter());
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
                      "Most Popular",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 20,
                            color: myFavColor,
                          ),
                    ),
                    SizedBox(
                      height: size.height * 20 / size.height,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildCompanyHomeCard(size: size, context: context),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 12,
                            ),
                        itemCount: 6),
                  ],
                ),
              if (searchController.text.isNotEmpty)
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildCompanyHomeCard(size: size, context: context),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    itemCount: 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCompanyHomeCard({
    required Size size,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: size.width * 392 / size.width,
        height: size.height * 204 / size.height,
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                                  Image.asset("assets/image/pdf 1.png"),
                                  const SizedBox(
                                    width: 11,
                                  ),
                                  Text(
                                    "Show CV",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 14,
                                          color: myFavColor,
                                      decoration: TextDecoration.underline,
                                        ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "UI,UX Designer",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 33,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 50,),
                        Icon(
                          Icons.location_pin,
                          color: myFavColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Alex, Egypt",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                            fontSize: 14,
                            color: myFavColor7,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 54,
                      width: 140,
                      child: myMaterialButton(
                        context: context,
                        onPressed: (){},
                        labelWidget: Text(
                          'Create Offer',
                          style: Theme.of(context).textTheme.button,
                        ),
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
