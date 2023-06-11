import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/layout_company/cubit/cubit.dart';
import 'package:we_work/layout_company/cubit/states.dart';
import 'package:we_work/modules/company/add_freelance_job/add_freelance_job_screen.dart';
import 'package:we_work/modules/company/add_job/add_job_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class LayoutCompanyScreen extends StatelessWidget {
  const LayoutCompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    return BlocConsumer<LayoutCompanyCubit, LayoutCompanyStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        LayoutCompanyCubit cubit = BlocProvider.of(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: cubit.companyScreens[cubit.currentIndex],
          bottomNavigationBar: BottomAppBar(
            color: myFavColor,
            shape: const CircularNotchedRectangle(),
            notchMargin: 10,
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeIndex(0,context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.house,
                            color: myFavColor5,
                          ),
                          if (cubit.currentIndex == 0)
                            const SizedBox(
                              height: 12,
                            ),
                          if (cubit.currentIndex == 0)
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: myFavColor5,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeIndex(1,context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.bell,
                            color: myFavColor5,
                          ),
                          if (cubit.currentIndex == 1)
                            const SizedBox(
                              height: 12,
                            ),
                          if (cubit.currentIndex == 1)
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: myFavColor5,
                            ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeIndex(3,context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/offers.png",
                            width: 32,
                            height: 32,
                          ),
                          if (cubit.currentIndex == 3)
                            const SizedBox(
                              height: 12,
                            ),
                          if (cubit.currentIndex == 3)
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: myFavColor5,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeIndex(4,context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.user,
                            color: myFavColor5,
                          ),
                          if (cubit.currentIndex == 4)
                            const SizedBox(
                              height: 12,
                            ),
                          if (cubit.currentIndex == 4)
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: myFavColor5,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: myFavColor,
            onPressed: () {
              if (!cubit.floatingButtonToggle) {
                showDialog(
                  context: context,
                  builder: (context) => Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 110),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                NavigateTo(
                                  context: context,
                                  widget: AddJobScreen(),
                                );
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: myFavColor5,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "N.J.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: myFavColor.withOpacity(0.8)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 50),
                            GestureDetector(
                              onTap: () {
                                NavigateTo(
                                  context: context,
                                  widget: AddFreelanceJobScreen(),
                                );
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: myFavColor5,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "F.J.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: myFavColor.withOpacity(0.8)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              cubit.changeToggle();
            },
            child: Icon(
              cubit.floatingButtonToggle ? Icons.close : Icons.add,
              color: myFavColor5,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
