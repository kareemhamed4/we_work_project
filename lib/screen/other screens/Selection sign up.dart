import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_work/screen/company_screen/sign%20up%20company.dart';
import 'package:we_work/screen/user_screen/sign%20up%20user.dart';

class SiginUp1 extends StatelessWidget {
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
            // signup1VA1 (97:633)

            padding: EdgeInsets.fromLTRB(0 * fem, 14 * fem, 0 * fem, 0),

            width: double.infinity,

            decoration: BoxDecoration(
              color: Color(0xffffffff),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // arrow11NHf (97:636)

                  margin: EdgeInsets.fromLTRB(16 * fem, 70, 0 * fem, 0 * fem),

                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 30 * fem,
                      height: 30 * fem,
                      child: Image.asset(
                        'assets/image/arrow (1) 1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  // undrawcommunityrecyrm1DZB (97:638)

                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 100 * fem),

                  width: 411 * fem,

                  height: 348 * fem,

                  child: Image.asset(
                    'assets/image/undraw_Community_re_cyrm 1.png',
                  ),
                ),
                Container(
                  // frame2J4q (97:634)

                  margin: EdgeInsets.fromLTRB(
                      16 * fem, 0 * fem, 16 * fem, 24 * fem),

                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpCompany()));
                    },
                    style: TextButton.styleFrom(),
                    child: Container(
                      width: double.infinity,
                      height: 59 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xff649344),
                        borderRadius: BorderRadius.circular(10 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Sign up As a Company',
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
                Container(
                  // frame3JU9 (97:635)

                  margin: EdgeInsets.fromLTRB(
                      16 * fem, 0 * fem, 16 * fem, 16 * fem),

                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpUser()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 59 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xff649344),
                        borderRadius: BorderRadius.circular(10 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Sign up As a User',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
