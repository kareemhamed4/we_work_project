import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/models/company/company_get_all_users_model.dart';
import 'package:we_work/modules/company/company_jobs/company_jobs_screen.dart';
import 'package:we_work/modules/company/filter/filter.dart';
import 'package:we_work/modules/company/home/cubit/cubit.dart';
import 'package:we_work/modules/company/home/cubit/states.dart';
import 'package:we_work/modules/company/message_for_offer/message_for_offer_screen.dart';
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
    return BlocConsumer<CompanyHomeCubit, CompanyHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CompanyHomeCubit cubit = BlocProvider.of(context);
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          NavigateTo(
                              context: context,
                              widget: const CompanyJobsScreen());
                        },
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
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
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: cubit.companyGetAllUsersModel != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 12 / size.height,
                        ),
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
                                    NavigateTo(
                                        context: context,
                                        widget: const CompanyFilter());
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
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
                                      buildCompanyHomeCard(
                                          size: size,
                                          context: context,
                                          index: index,
                                          model:
                                              cubit.companyGetAllUsersModel!),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 12,
                                      ),
                                  itemCount: cubit
                                      .companyGetAllUsersModel!.data!.length),
                            ],
                          ),
                        if (searchController.text.isNotEmpty)
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                buildCompanyHomeCard(
                                    size: size,
                                    context: context,
                                    index: index,
                                    model: cubit.companyGetAllUsersModel!),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 12,
                            ),
                            itemCount:
                                cubit.companyGetAllUsersModel!.data!.length,
                          ),
                        SizedBox(
                          height: size.height * 20 / size.height,
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                      color: myFavColor,
                    )),
            ),
          ),
        );
      },
    );
  }

  Widget buildCompanyHomeCard({
    required Size size,
    required int index,
    required BuildContext context,
    required CompanyGetAllUsersModel model,
  }) =>
      Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/image/person.png"),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              model.data![index].displayName ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 14,
                                    color: myFavColor7,
                                  ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              model.data![index].bio ?? "",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.filePdf,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Show CV",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.location_pin,
                            color: myFavColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${model.data![index].city ?? ""}, ${model.data![index].country ?? ""}",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14,
                                      color: myFavColor7,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: myMaterialButton(
                        context: context,
                        onPressed: () {
                          NavigateTo(
                              context: context,
                              widget: MessageOfferScreen(
                                userId: model.data![index].id!,
                              ));
                        },
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
      );
}
