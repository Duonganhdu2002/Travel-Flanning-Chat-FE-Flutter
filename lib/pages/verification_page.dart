import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  final String username;
  final String password;

  const VerificationPage(
      {required this.email,
      required this.username,
      required this.password,
      super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController otpController = TextEditingController();

  void _verifyOTP() async {
    final otp = otpController.text;

    if (otp.isNotEmpty) {
      bool success = await AuthService.verifyOTP(
          widget.email, otp, widget.username, widget.password);

      if (success && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid OTP. Please try again."),
          ),
        );
      }
    }
  }

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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "Please check your email ${widget.email} to see the verification code",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black45,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "OTP CODE",
                    style: GoogleFonts.roboto(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: TextField(
                controller: otpController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: _verifyOTP,
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
                    child: Text("Verify OTP"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
