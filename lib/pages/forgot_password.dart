import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
              "Forgot password",
              style: GoogleFonts.roboto(
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Enter your email account to reset your password",
              style: GoogleFonts.roboto(
                fontSize: 16, 
                color: Colors.black45,
              ),
            ),

            // Orther coponents here
            //Your code...
          ],
        ),
      ),
    );
  }
}
