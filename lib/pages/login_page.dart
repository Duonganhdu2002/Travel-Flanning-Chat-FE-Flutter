import 'package:flutter/material.dart';
import 'package:flutter_app/pages/forgot_password.dart';
import 'package:flutter_app/pages/on_bording_page.dart';
import 'package:flutter_app/pages/signup_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnBordingPage(),
                ),
              );
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Sign in now",
              style: GoogleFonts.roboto(
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Please sign in to continue our app",
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.black45,
              ),
            ),

            // Orther coponents here
            //Your code...

            // Delele below code (SizeBox)
            const SizedBox(
              height: 500,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()),
                      );
                    },
                    child: Text(
                      "Forgot password",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.yellow[600],
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 200,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: Text(
                    "Sign up",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.yellow[600],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
