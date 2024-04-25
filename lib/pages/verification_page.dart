import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/pages/forgot_password.dart';

Color textFieldBackgroundColor = const Color(0xFFF7F7F9);

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>{
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: BackButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgotPassword()),
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
            "OTP Verification",
            style: GoogleFonts.roboto(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        
          const SizedBox(
            height: 10,
          ),
           Text(
            "Please check your email www.uihut@gmail.com to see the verification code",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.black45,
            ),
          ),

          const SizedBox(
            height: 40,
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "OTP CODE",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          ),
           Padding(padding:  const EdgeInsets.symmetric(horizontal:20,vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 56,
                    width: 70,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textFieldBackgroundColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14)
                        ),
                      ),
                    ),
                ),
                SizedBox(
                    height: 56,
                    width: 70,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textFieldBackgroundColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14)
                        ),
                      ),
                    ),
                ),
                SizedBox(
                    height: 56,
                    width: 70,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textFieldBackgroundColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14)
                        ),
                      ),
                    ),
                ),
                SizedBox(
                    height: 56,
                    width: 70,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textFieldBackgroundColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14)
                        ),
                      ),
                    ),
                ),
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
                    child: Text("Verify"),
                  ),
                )
                )
              ],
            ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Resend code to"
              ),
              Text(
                "01:36"
              ),
            ],
          ),

          
        ],
      ),
    ),
    );
  }
}