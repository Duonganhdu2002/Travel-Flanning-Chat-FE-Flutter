import 'package:flutter/material.dart';
import 'package:flutter_app/models/register_request_model.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/verification_page.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:flutter_app/config.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
      body: const SingUpForm(),
    );
  }
}

class SingUpForm extends StatefulWidget {
  const SingUpForm({super.key});

  @override
  State<SingUpForm> createState() => _SingUpFormState();
}

class _SingUpFormState extends State<SingUpForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isApiAccess = false;

  void _signup() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isApiAccess = true;
      });

      final username = usernameController.text;
      final email = emailController.text;
      final password = passwordController.text;

      RegisterRequestModel model = RegisterRequestModel(
        username: username,
        email: email,
        password: password,
      );

      AuthService.register(model).then(
        (response) {
          setState(() {
            isApiAccess = false;
          });

          if (response.message == "OTP sent to email. Please verify to complete registration.") {
            FormHelper.showSimpleAlertDialog(
              context,
              Config.appName,
              response.message.toString(),
              "OK",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerificationPage(
                      email: email,
                      password: password,
                      username: username,
                    ),
                  ),
                );
              },
            );
          } else {
            FormHelper.showSimpleAlertDialog(
              context,
              Config.appName,
              response.message.toString(),
              "OK",
              () {
                Navigator.of(context).pop();
              },
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: SingleChildScrollView(
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
                    TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        hintText: 'Enter username ',
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        hintText: 'Enter Email ',
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
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
                    onPressed: _signup,
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
      ),
    );
  }
}
