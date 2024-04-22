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
            
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
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
                    hintText: 'Nhập email ',
                  ),
                ),
                const SizedBox(height: 50), // Khoảng cách giữa hai TextField
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textFieldBackgroundColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    hintText: 'Nhập password ',
                  ),
                ),
              ],
            ),
          ),


            // Delele below code (SizeBox)
            

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
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

            const SizedBox(
              height: 40,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {
                   
                },
                style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                foregroundColor: Colors.white, backgroundColor: Colors.yellow[600],
                ),
                child: const SizedBox(
                  width: 335.0,
                  height: 56.0,
                  child: Center(
                    child: Text("Sign in"),

                  ),
                )
                
                )
              ],
            ),

            const SizedBox(
              height: 40,
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
                ),

                
              ],
            ),
            const SizedBox(
                  height:15,
                ),
                Text(
                  "Or connect ",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                  ),
                ),
            const SizedBox(
                  height: 50,
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){}, icon: Image.asset('lib/images/LogoFB.png')),
                IconButton(onPressed: (){}, icon: Image.asset('lib/images/LogoInsta.png')),
                IconButton(onPressed: (){}, icon: Image.asset('lib/images/LogoChimXanh.png'))
              ],
            ),     
          ],
        ),
      ),
    );
  }
}
