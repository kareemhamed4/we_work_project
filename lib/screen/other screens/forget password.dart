import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/text_field.dart';
import 'Confirm the message.dart';

class ForgetPassword extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Container(
          // signup1VA1 (97:633)
          padding: EdgeInsets.fromLTRB(0*fem, 14*fem, 0*fem,0),
          width: double.infinity,
          decoration: BoxDecoration (
            color: Color(0xffffffff),
          ),
          child:  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // arrow11NHf (97:636)
                  margin: EdgeInsets.fromLTRB(16*fem, 70, 0*fem, 0*fem),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(

                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            'assets/image/arrow (1) 1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 70,),
                        Text(
                          'Forget Password',
                          style:  GoogleFonts.roboto (

                            fontSize: 20*ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.1725*ffem/fem,
                            color: Color(0xff649344),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // undrawcommunityrecyrm1DZB (97:638)
                  margin: EdgeInsets.fromLTRB(37, 0*fem, 40, 20*fem),
                  width: 351,
                  height: 269,
                  child: Image.asset(
                    'assets/image/Rectangle 3.png',
                  ),
                ),
                Center(
                  child: Container(
                    // helpsyouinyouronlinejobsearcht (97:631)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 2.33*fem, 20*fem),
                    constraints: BoxConstraints (
                      maxWidth: 313*fem,
                    ),
                    child: Text(
                      'Please enter your email addres  to  receive vertification card',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans (
                        fontSize: 16*ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.5625*ffem/fem,
                        color: Color(0xff676767),
                      ),
                    ),
                  ),
                ),
                Container(

                  margin: EdgeInsets.fromLTRB(12*fem, 7*fem, 0*fem, 7*fem),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Custom_TextFormfield(),
                ),
                Container(
                  // frame3JU9 (97:635)
                  margin: EdgeInsets.fromLTRB(16*fem, 15*fem, 16*fem, 0*fem),
                  child: TextButton(
                    onPressed: () {
                       Navigator.push( context,MaterialPageRoute(builder: (context) =>    ConfirmMessage()));


                    },
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 59*fem,
                      decoration: BoxDecoration (
                        color: Color(0xff649344),
                        borderRadius: BorderRadius.circular(10*fem),
                      ),
                      child: Center(
                        child: Text(
                          'send',
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