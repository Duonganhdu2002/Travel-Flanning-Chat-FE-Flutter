import 'package:flutter/material.dart';
import 'package:flutter_app/pages/forgot_password.dart';
import 'package:flutter_app/pages/on_bording_page.dart';
import 'package:flutter_app/pages/signup_page.dart';
import 'package:google_fonts/google_fonts.dart';

Color textFieldBackgroundColor = const Color(0xFFF7F7F9);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            // Sign up now text

            const SizedBox(
              height: 40,
            ),
            Text(
              "Sign in now",
              style: GoogleFonts.roboto(
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
            ),

            // Please sign in to continue our app

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

            // Form input

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
              child: Column(
                children: [
                  
                  // Input email

                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: textFieldBackgroundColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      hintText: 'Enter your email ',
                    ),
                  ),

                  // Space between two inputs

                  const SizedBox(height: 50),

                  // Input password

                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: textFieldBackgroundColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      hintText: 'Enter your password ',
                    ),
                  ),
                ],
              ),
            ),

            // Forgot password

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
                      "Forgot password?",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.yellow[600],
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Space Forgot password

            const SizedBox(
              height: 40,
            ),

            // Button sign up

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.yellow[600],
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text("Sign in"),
                    ),
                  ),
                ),
              ),
            ),

            // Space

            const SizedBox(
              height: 40,
            ),

            // Don't have an account

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
                ),
              ],
            ),

            // Space

            const SizedBox(
              height: 15,
            ),

            // Or conncet

            Text(
              "Or connect ",
              style: GoogleFonts.roboto(
                fontSize: 16,
              ),
            ),

            //Space

            const SizedBox(
              height: 100,
            ),

            // Row of icons

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Image.asset('lib/images/LogoFB.png')),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset('lib/images/LogoInsta.png')),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset('lib/images/LogoChimXanh.png'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
