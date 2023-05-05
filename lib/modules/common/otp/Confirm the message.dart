import 'package:flutter/material.dart';
import 'package:we_work/modules/common/new_password/Change%20the%20password.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class ConfirmMessage extends StatelessWidget {
  const ConfirmMessage({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify your email",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: myFavColor, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: size.height * 30 / size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/Rectangle 3 (1).png',
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: size.height * 56 / size.height,
              ),
              Text(
                'Please enter 4 digit which send to your email',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(fontSize: 16, height: 1.5),
              ),
              SizedBox(
                height: size.height * 56 / size.height,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 62,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xfff0f0f0),
                        ),
                      ),
                      Container(
                        width: 62,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff649344),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 62,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xfff0f0f0),
                        ),
                      ),
                      Container(
                        width: 62,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff649344),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 62,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xfff0f0f0),
                        ),
                      ),
                      Container(
                        width: 62,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff649344),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 62,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xfff0f0f0),
                        ),
                      ),
                      Container(
                        width: 62,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff649344),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 120 / size.height,
              ),
              myMaterialButton(
                context: context,
                onPressed: () {
                  NavigateTo(context: context, widget: const ChangePassword());
                },
                labelWidget: Text(
                  'Verify',
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
