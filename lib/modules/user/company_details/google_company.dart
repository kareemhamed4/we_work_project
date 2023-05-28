import 'package:flutter/material.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyDetails extends StatelessWidget {
  const CompanyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Company Details',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: myFavColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: UserHomeCubit.get(context)
              .userProfileModel != null ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (UserHomeCubit.get(context)
                      .userProfileModel!
                      .profilePictureUrl !=
                  null)
                CircleAvatar(
                  radius: 40,
                  backgroundColor: myFavColor3,
                  backgroundImage: NetworkImage(UserHomeCubit.get(context)
                      .userProfileModel!
                      .profilePictureUrl!),
                ),
              if (UserHomeCubit.get(context)
                      .userProfileModel!
                      .profilePictureUrl ==
                  null)
                CircleAvatar(
                  radius: 40,
                  backgroundColor: myFavColor3,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: myFavColor4,
                  ),
                ),
              const SizedBox(
                height: 16,
              ),
              Text(
                UserHomeCubit.get(context).userProfileModel!.displayName?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Color(0xff649344),
                  ),
                  Text(
                    "${UserHomeCubit.get(context).userProfileModel!.city?? ""} , ${UserHomeCubit.get(context).userProfileModel!.country?? ""}",
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
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
                                    .labelLarge!
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
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "About Company",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff649344)),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        UserHomeCubit.get(context).userProfileModel!.bio?? "",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Since",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff649344)),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        UserHomeCubit.get(context).userProfileModel!.dateOfCreation?? "",
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Email",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff649344)),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        UserHomeCubit.get(context).userProfileModel!.email ?? "",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ) : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
