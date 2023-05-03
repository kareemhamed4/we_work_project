import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Selection sign up.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Container(
          // onboardingscrren2mf (97:626)
          padding:
              EdgeInsets.fromLTRB(16 * fem, 14 * fem, 14.67 * fem, 46 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(5 * fem),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // rectangle1X1b (97:629)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 1.33 * fem, 0 * fem),
                  width: 396 * fem,
                  height: 392 * fem,
                  child: Image.asset(
                    'assets/image/Rectangle 1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  // ourappQLH (97:630)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 0.33 * fem, 38 * fem),
                  child: Text(
                    'Our App',
                    style: GoogleFonts.roboto(
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.1725 * ffem / fem,
                      color: Color(0xff649344),
                    ),
                  ),
                ),
                Container(
                  // helpsyouinyouronlinejobsearcht (97:631)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 2.33 * fem, 77 * fem),
                  constraints: BoxConstraints(
                    maxWidth: 313 * fem,
                  ),
                  child: Text(
                    '  helps you in your online job search to find Jobs in Egypt and Middle East. Choose the right job using our online recruitment services',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.5625 * ffem / fem,
                      color: Color(0xff676767),
                    ),
                  ),
                ),
                Container(
                  // frame24p9 (97:628)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 1.33 * fem, 88 * fem),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SiginUp1()));
                      },
                      child: Container(
                        width: 396 * fem,
                        height: 59 * fem,
                        decoration: BoxDecoration(
                          color: Color(0xff649344),
                          borderRadius: BorderRadius.circular(10 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: GoogleFonts.roboto(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.1725 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  // skipfJ9 (97:627)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 365.33 * fem, 0 * fem),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.roboto(
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.1725 * ffem / fem,
                        color: Color(0xff737373),
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
