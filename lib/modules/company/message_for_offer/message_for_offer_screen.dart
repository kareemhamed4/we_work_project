import 'package:flutter/material.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class MessageOfferScreen extends StatelessWidget {
  const MessageOfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Offer',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: myFavColor, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company offer',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: myFavColor),
            ),
            const SizedBox(
              height: 18,
            ),
            SizedBox(
              height: size.height * 454/size.height,
              child: buildFeedbackBox(
                  context: context,
                  hint: "",
                  messageController: messageController,
              ),
            ),
            const Spacer(),
            myMaterialButton(
              context: context,
              onPressed: () {},
              labelWidget: Text(
                'Confirm',
                style: Theme.of(context).textTheme.button,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}
