import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/modules/user/apply_job/cubit/cubit.dart';
import 'package:we_work/modules/user/apply_job/cubit/states.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/saved_jobs/cubit/cubit.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class ApplyJobScreen extends StatefulWidget {
  final int jobId;
  const ApplyJobScreen({super.key, required this.jobId});
  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  TextEditingController textMessageController = TextEditingController();
  List<double> dashPattern = [6, 6];
  var formKey = GlobalKey<FormState>();
  String? messageEnter;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserApplyJobCubit, UserApplyJobStates>(
      listener: (context, state) {
        if (state is UserApplyJobSuccessState) {
          UserGetAppliedJobsCubit.get(context).userGetAppliedJobs().then((value){
            UserHomeCubit.get(context).userGetAllJob();
            NavigateToReb(context: context, widget: const LayoutScreen());
            LayoutCubit.get(context).changeIndex(2);
            buildSuccessToast(
              title: "Done",
              context: context,
              description: state.msg,
            );
          });
        }
        if (state is UserApplyJobErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        UserApplyJobCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Upload CV',
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        print(cubit.filePath);
                      },
                      child: Text(
                        "Add a certification to apply to a job",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      color: myFavColor4,
                      dashPattern: dashPattern,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(6),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              width: double.infinity,
                              height: size.height * 178 / size.height,
                              color: myFavColor5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 125,
                                    child: myMaterialButton(
                                      context: context,
                                      labelWidget: Text(
                                        cubit.result != null
                                            ? "Uploaded!"
                                            : "Upload CV",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: myFavColor5, fontSize: 16),
                                      ),
                                      onPressed: () async {
                                        cubit.chooseCVFile();
                                      },
                                    ),
                                  ),
                                  mySizedBox(size: size, myHeight: 6),
                                  Text(
                                    cubit.result != null
                                        ? cubit.fileName!
                                        : "PDF files only accepted",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 16, color: myFavColor4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if(cubit.filePath != null)
                            Padding(
                            padding: const EdgeInsets.only(right: 8.0,top: 8),
                            child: myTextButton(
                                context: context,
                                label: "Cancel File",
                                onPressed: (){
                                  cubit.deleteSelectedPdf();
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "Information",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buildFeedbackBox(
                      context: context,
                      hint: "Why you see this job Suitable for you?",
                      messageController: textMessageController,
                    ),
                    const SizedBox(
                      height: 41,
                    ),
                    ConditionalBuilder(
                      condition: state is! UserApplyJobLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (cubit.result != null) {
                              cubit.applyToJob(
                                jobId: widget.jobId,
                                message: textMessageController.text,
                              );
                            }
                          }
                        },
                        labelWidget: Text(
                          'Send',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      fallback: (context) => myMaterialButton(
                        context: context,
                        onPressed: (){
                          null;
                        }, // Disable the button when loading
                        labelWidget: const Center(
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
