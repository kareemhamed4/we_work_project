import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:we_work/modules/user/filter/filter.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/modules/user/job_details/job_details_google.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/components/custom_card.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
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
    return BlocConsumer<UserHomeCubit, UserHomeStates>(
      listener: (context, state) {
        if(state is UserGetJobDetailsLoadingState){
          showProgressIndicator(
            context
          );
        }
      },
      builder: (context, state) {
        UserHomeCubit cubit = BlocProvider.of(context);
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
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16, top: 20),
                  child: Row(
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
                                  context: context, widget: const Filter());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                if (searchController.text.isEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          "Available Jobs",
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontSize: 20,
                                    color: myFavColor,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 20 / size.height,
                      ),
                      if(cubit.userGetAllJobsModel != null)
                        SizedBox(
                        height: size.height * 192 / 780,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.userGetAllJobsModel!.count!,
                            itemBuilder: (context,index) => Column(
                              children: [
                                const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    const SizedBox(width: 8,),
                                    GestureDetector(
                                      onTap: (){
                                        cubit.userGetJobDetails(id: cubit.userGetAllJobsModel!.data![index].id!).then((value){
                                          Navigator.pop(context);
                                          NavigateTo(context: context, widget: GoogleJobDetails(userGetJobDetailsModel: cubit.userGetJobDetailsModel!,));
                                        });
                                      },
                                      child: CustomCard(
                                        width: size.width - 50,
                                        index: 0,
                                        pageTitle: cubit.userGetAllJobsModel!.data![index].user ?? "",
                                        imageLocation: "assets/image/google.svg",
                                        jobTitle: cubit.userGetAllJobsModel!.data![index].title ?? "",
                                        jobDescription: cubit.userGetAllJobsModel!.data![index].description ?? "",
                                        salary: cubit.userGetAllJobsModel!.data![index].salary.toString(),
                                        location: "${cubit.userGetAllJobsModel!.data![index].city} , ${cubit.userGetAllJobsModel!.data![index].country}",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                              ],
                            ),
                            separatorBuilder: (context,index) => const SizedBox(width: 10,),
                          ),
                        ),
                      ),
                      if(cubit.userGetAllJobsModel == null)
                        Center(child: CircularProgressIndicator(color: myFavColor,)),
                      SizedBox(
                        height: size.height * 20 / size.height,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          "Freelancing Jobs",
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontSize: 20,
                                    color: myFavColor,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 20 / size.height,
                      ),
                      if(cubit.userGetRemotlyJobsModel != null)
                        SizedBox(
                        height: size.height * 192 / 780,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.userGetRemotlyJobsModel!.count!,
                            itemBuilder: (context,index) => Column(
                              children: [
                                const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    const SizedBox(width: 8,),
                                    CustomCard(
                                      width: size.width - 50,
                                      index: 0,
                                      pageTitle: cubit.userGetRemotlyJobsModel!.data![index].user ?? "",
                                      imageLocation: "assets/image/google.svg",
                                      jobTitle: cubit.userGetRemotlyJobsModel!.data![index].title ?? "",
                                      jobDescription: cubit.userGetRemotlyJobsModel!.data![index].description ?? "",
                                      salary: cubit.userGetRemotlyJobsModel!.data![index].salary.toString(),
                                      location: "${cubit.userGetRemotlyJobsModel!.data![index].city} , ${cubit.userGetAllJobsModel!.data![index].country}",
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                              ],
                            ),
                            separatorBuilder: (context,index) => const SizedBox(width: 10,),
                          ),
                        ),
                      ),
                      if(cubit.userGetRemotlyJobsModel == null)
                        Center(child: CircularProgressIndicator(color: myFavColor,)),
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
        );
      },
    );
  }
}
