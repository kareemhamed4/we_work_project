import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/user_compont.dart';

class CompanyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(
          child: Text(
            "My Profile",
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                radius: 30,
                backgroundImage: AssetImage("assets/image/google (1) 1.png"),
                foregroundColor: Colors.white,
              )),
              Text(
                "Google",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Item(
                icon: Icons.local_activity_outlined,
                title: 'Activity',
              ),

              Item(
                icon: Icons.location_on_outlined,
                title: 'Location',
              ),
              Item(
                icon: Icons.groups_outlined,
                title: 'Number of employee',
              ),
              Item(
                icon: Icons.location_on_outlined,
                title: 'Adress',
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.power_settings_new_rounded,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                      Flexible(
                          child: SizedBox(
                        width: double.infinity,
                      )),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 18,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
