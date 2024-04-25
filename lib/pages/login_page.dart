import 'package:flutter/material.dart';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/models/login_request_model.dart';
import 'package:flutter_app/pages/forgot_password.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/signup_page.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

Color textFieldBackgroundColor = const Color(0xFFF7F7F9);

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: BackButton(
            onPressed: () {
              Navigator.pop(context); // Go back to previous screen
            },
          ),
        ),
      ),
      body: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isApiAccess = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: SingleChildScrollView(
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 30.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
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
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      obscureText: true,
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
                            builder: (context) => const ForgotPassword(),
                          ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: ElevatedButton(
                  onPressed: _login,
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

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Validation passed, perform login
      setState(() {
        isApiAccess = true;
      });

      final email = emailController.text;
      final password = passwordController.text;

      LoginRequestModel model = LoginRequestModel(
        email: email,
        password: password,
      );

      APIService.login(model).then(
        (response) {
          setState(() {
            isApiAccess = false;
          });

          if (response == true) {
            // Login successful
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else {
            // Login failed
            FormHelper.showSimpleAlertDialog(
              context,
              Config.appName,
              "Invalid Username/Password !!",
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
}
