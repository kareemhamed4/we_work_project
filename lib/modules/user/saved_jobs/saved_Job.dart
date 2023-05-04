import 'package:flutter/material.dart';
import 'package:we_work/shared/components/custom_card.dart';
import 'package:we_work/shared/styles/colors.dart';

class SavedJob extends StatelessWidget {
  const SavedJob({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Job',
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
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context,index)=>buildSavedJobs(),
                  separatorBuilder: (context,index)=>const SizedBox(height: 23,),
                  itemCount: 3
              ),
            ),
          ],
        ),
      ),
    );
  }

  CustomCard buildSavedJobs() {
    return CustomCard(
            index: 0,
            isSaved: true,
            pageTitle: 'Google',
            imageLocation: "assets/image/google (1) 1.png",
            jobTitle: 'Flutter Developer',
            jobDescription:
            '  Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            salary: "500",
            location: 'Alex , EGYPT',
          );
  }
}
