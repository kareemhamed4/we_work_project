import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_work/screen/user_screen/user_login.dart';
import '../../components/text_field.dart';

class SignUpUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Container(
          padding:
              EdgeInsets.fromLTRB(17 * fem, 14 * fem, 14.67 * fem, 0 * fem),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 50 * fem, 166.33 * fem, 50 * fem),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
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
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        'Sign up',
                        style: GoogleFonts.roboto(
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.1725 * ffem / fem,
                          color: Color(0xff649344),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 7 * fem, 0 * fem, 7 * fem),
                  child: Text(
                    'Name',
                    style: GoogleFonts.roboto(
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.1725 * ffem / fem,
                      color: Color(0xb5686868),
                    ),
                  ),
                ),
                Custom_TextFormfield(),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 7 * fem, 0 * fem, 7 * fem),
                  child: Text(
                    'Email',
                    style: GoogleFonts.roboto(
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.1725 * ffem / fem,
                      color: Color(0xb5686868),
                    ),
                  ),
                ),
                Custom_TextFormfield(),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 7 * fem, 0 * fem, 7 * fem),
                  child: Text(
                    'Password',
                    style: GoogleFonts.roboto(
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.1725 * ffem / fem,
                      color: Color(0xb5686868),
                    ),
                  ),
                ),
                Custom_TextFormfield(
                  scure: true,
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 7 * fem, 0 * fem, 7 * fem),
                  child: Text(
                    'Confirm_Password',
                    style: GoogleFonts.roboto(
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.1725 * ffem / fem,
                      color: Color(0xb5686868),
                    ),
                  ),
                ),
                Custom_TextFormfield(
                  scure: true,
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 7 * fem, 0 * fem, 7 * fem),
                  child: Text(
                    'Job_type',
                    style: GoogleFonts.roboto(
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.1725 * ffem / fem,
                      color: Color(0xb5686868),
                    ),
                  ),
                ),
                Custom_TextFormfield(),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 7 * fem, 0 * fem, 7 * fem),
                  child: Text(
                    'Phone_Number',
                    style: GoogleFonts.roboto(
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.1725 * ffem / fem,
                      color: Color(0xb5686868),
                    ),
                  ),
                ),
                Custom_TextFormfield(),
                Container(
                  // frame4iw3 (97:646)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 7 * fem, 0.33 * fem, 6 * fem),
                  child: TextButton(
                    onPressed: () {},
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
                          'Sign Up',
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
                  // arleadyhaveaccountsigninkMw (97:648)
                  margin: EdgeInsets.fromLTRB(
                      216.67 * fem, 0 * fem, 0 * fem, 0 * fem),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.roboto(
                          fontSize: 12 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.171875 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                        children: [
                          TextSpan(
                            text: 'Arleady have account?',
                            style: GoogleFonts.roboto(
                              fontSize: 12 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.1725 * ffem / fem,
                              color: Color(0xce808080),
                            ),
                          ),
                          TextSpan(
                            text: ' Log in',
                            style: GoogleFonts.roboto(
                              fontSize: 12 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.1725 * ffem / fem,
                              color: Color(0xff649344),
                            ),
                          ),
                        ],
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
