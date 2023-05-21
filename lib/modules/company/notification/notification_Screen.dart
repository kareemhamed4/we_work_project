import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:we_work/modules/company/applied_job/applied_job_screen.dart';
import 'package:we_work/modules/company/notification/cubit/cubit.dart';
import 'package:we_work/modules/company/notification/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyNotificationScreen extends StatelessWidget {
  const CompanyNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyGetUsersWhoAppliedCubit,
        CompanyGetUsersWhoAppliedStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CompanyGetUsersWhoAppliedCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Notification',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: myFavColor, fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: cubit.companyGetAllUsersApplied != null
                ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "You have",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Text(
                              "${cubit.companyGetAllUsersApplied!.length} Notification",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: myFavColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (cubit.companyGetAllUsersApplied!.isNotEmpty)
                          ListView.separated(
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.companyGetAllUsersApplied!.length,
                            itemBuilder: (context, index) => GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                NavigateTo(
                                    context: context,
                                    widget: const AppliedJobScreen());
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/image/google.svg"),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cubit
                                                  .companyGetAllUsersApplied![
                                                      index]
                                                  .displayName ??
                                              "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(color: myFavColor),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "applied for a your job as \"${cubit.companyGetAllUsersApplied![index].titleOfJob}\"",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                myDivider(height: 20),
                          ),
                        if (cubit.companyGetAllUsersApplied!.isEmpty)
                          Center(
                            child: Text(
                              "You Don't have any applied jobs until now",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: myFavColor,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
