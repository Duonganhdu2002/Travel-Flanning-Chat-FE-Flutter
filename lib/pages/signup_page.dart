import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Sign up now",
              style: GoogleFonts.roboto(
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Please fill the details and create account",
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.black45,
              ),
            ),

            // Orther coponents here
            //Your code...

            // Delele below code (SizeBox)
            const SizedBox(
              height: 700,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: Text(
                    "Sign in",
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
