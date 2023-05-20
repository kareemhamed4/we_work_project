import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/modules/user/profile/cubit/cubit.dart';
import 'package:we_work/modules/user/profile/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController bioController = TextEditingController();
    var model = UserProfileCubit.get(context).userProfileModel;
    bioController.text = model != null ? model.bio ?? bioController.text : " ";
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserProfileCubit, UserProfileStates>(
      listener: (context, state) {
        if (state is UserUpdateProfileSuccessState) {
          NavigateToReb(context: context, widget: const LayoutScreen());
          LayoutCubit.get(context).changeIndex(4);
          buildSuccessToast(
            title: "Done",
            context: context,
            description: state.msg,
          );
        }
        if (state is UserUpdateProfileErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        UserProfileCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Update Profile Info',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: myFavColor, fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mySizedBox(size: size, myHeight: 8),
                  Text(
                    'Bio',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 14),
                  ),
                  mySizedBox(size: size, myHeight: 8),
                  myTextFormField(
                    context: context,
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your bio";
                      }
                      return null;
                    },
                  ),
                  mySizedBox(size: size, myHeight: 24),
                  Spacer(),
                  ConditionalBuilder(
                    condition: state is! UserUpdateProfileLoadingState,
                    builder: (context) => myMaterialButton(
                      context: context,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.updateUserInfo(bio: bioController.text);
                        }
                      },
                      labelWidget: Text(
                        'Update',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    fallback: (context) => myMaterialButton(
                      context: context,
                      onPressed: () {
                        null;
                      },
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
                  mySizedBox(size: size, myHeight: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
