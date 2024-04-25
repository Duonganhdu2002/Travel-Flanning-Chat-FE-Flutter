import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

Color textFieldBackgroundColor = const Color(0xFFF7F7F9);

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

      // Body

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
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: textFieldBackgroundColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      hintText: 'Enter username ',
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: textFieldBackgroundColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      hintText: 'Enter Email ',
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: textFieldBackgroundColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      hintText: 'Enter password ',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Password must be 8 character",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
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
                    height: 56.0,
                    child: Center(
                      child: Text("Sign up"),
                    ),
                  )),
            ),
            const SizedBox(
              height: 40,
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
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Or connect ",
              style: GoogleFonts.roboto(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
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
