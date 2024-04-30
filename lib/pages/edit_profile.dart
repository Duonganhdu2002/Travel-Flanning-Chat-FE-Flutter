import 'package:flutter/material.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/ultils/app_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: const CustomBar(
        leftWidget: BackIcon(),
        centerWidget1: Text(
          "Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        rightWidget: Text(
          "Done",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.amber),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              ClipOval(
                child: Image.asset(
                  'lib/images/image1.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Leonardo",
                  style: TextStyle(
                      color: Color(0xFF1B1E28),
                      fontSize: 28,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const Text(
                "Change Profile Picture",
                style: TextStyle(fontSize: 18, color: Colors.amber),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Column(
                  children: [
                    customTextField(
                        "Full Name",
                        const Color(0xFFF7F7F9),
                        true,
                        BorderSide.none,
                        BorderRadius.circular(14),
                        "Leonardo",
                        true),
                    customTextField(
                        "Email",
                        const Color(0xFFF7F7F9),
                        true,
                        BorderSide.none,
                        BorderRadius.circular(14),
                        "Leonardo",
                        true),
                    customTextField(
                        "Location",
                        const Color(0xFFF7F7F9),
                        true,
                        BorderSide.none,
                        BorderRadius.circular(14),
                        "Leonardo",
                        true),
                    customTextField(
                        "Mobile Number",
                        const Color(0xFFF7F7F9),
                        true,
                        BorderSide.none,
                        BorderRadius.circular(14),
                        "Leonardo",
                        false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField(
      String lable,
      Color color,
      bool filled,
      BorderSide borderSide,
      BorderRadius borderRadius,
      String hintText,
      bool isCorrect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            lable,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            filled: filled,
            fillColor: color,
            border: OutlineInputBorder(
              borderSide: borderSide,
              borderRadius: borderRadius,
            ),
            hintText: hintText,
            suffixIcon: Icon(
              Icons.check,
              color: isCorrect ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
