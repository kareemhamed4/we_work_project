import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/text_field.dart';

class ChangePassword extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Container(
            // forgetpassworduXo (97:692)
            padding: EdgeInsets.fromLTRB(13*fem, 90*fem, 14.67*fem, 36*fem),
            width: double.infinity,
            decoration: BoxDecoration (
              color: Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  // autogroupi35tVAZ (EeZBFuwrqyNjGC9GAvi35T)
                  margin: EdgeInsets.fromLTRB(3*fem, 0*fem, 95.33*fem, 53*fem),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // arrow11mNy (97:693)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 63*fem, 0*fem),
                        width: 30*fem,
                        height: 30*fem,
                        child: Image.asset(
                          'assets/image/arrow (1) 1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        // createanewpassword4cy (97:696)
                        margin: EdgeInsets.fromLTRB(0*fem, 2*fem, 0*fem, 0*fem),
                        child: Text(
                          'Create a new password',
                          style: GoogleFonts.roboto (

                            fontSize: 20*ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.1725*ffem/fem,
                            color: Color(0xff649344),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // rectangle3LqP (97:697)
                  margin: EdgeInsets.fromLTRB(0.67*fem, 0*fem, 0*fem, 20*fem),
                  width: 365*fem,
                  height: 279*fem,
                  child: Image.asset(
                    'assets/image/Rectangle 3 (2).png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  // pleaseenteranewpasswordmustbed (97:698)
                  margin: EdgeInsets.fromLTRB(1.67*fem, 0*fem, 0*fem, 36*fem),
                  constraints: BoxConstraints (
                    maxWidth: 269*fem,
                  ),
                  child: Text(
                    'Please enter anew password must be different from previously password',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans (

                      fontSize: 16*ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.5625*ffem/fem,
                      color: Color(0xff676767),
                    ),
                  ),
                ),
                Container(
                  // component45Rb (97:699)
                  margin: EdgeInsets.fromLTRB(2*fem, 0*fem, 2.33*fem, 24*fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // companynamePBP (I97:699;8:79)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 7*fem),
                        child: Text(
                          'Enter your email',
                          style: GoogleFonts.roboto (

                            fontSize: 14*ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.1725*ffem/fem,
                            color: Color(0xb5686868),
                          ),
                        ),
                      ),
                      Container(
                        // rectangle254D (I97:699;8:78)
                        width: double.infinity,
                        height: 54*fem,
                        child: Custom_TextFormfield(),
                      ),
                    ],
                  ),
                ),
                Container(
                  // component5Bd3 (97:700)
                  margin: EdgeInsets.fromLTRB(2*fem, 0*fem, 2.33*fem, 45*fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // companyname6V7 (I97:700;8:79)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 7*fem),
                        child: Text(
                          'Enter your  new password',
                          style: GoogleFonts.roboto (

                            fontSize: 14*ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.1725*ffem/fem,
                            color: Color(0xb5686868),
                          ),
                        ),
                      ),
                      Container(
                        // rectangle2mr9 (I97:700;8:78)
                        width: double.infinity,
                        height: 54*fem,
                        child: Custom_TextFormfield(),
                      ),
                    ],
                  ),
                ),
                Container(
                  // frame4tQy (97:695)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4.33*fem, 0*fem),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 396*fem,
                      height: 59*fem,
                      decoration: BoxDecoration (
                        color: Color(0xff649344),
                        borderRadius: BorderRadius.circular(10*fem),
                      ),
                      child: Center(
                        child: Text(
                          'Vertify ',
                          style: GoogleFonts.roboto (

                            fontSize: 16*ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.1725*ffem/fem,
                            color: Color(0xffffffff),
                          ),
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

  }

}