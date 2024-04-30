import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/services/api_service.dart';

class ImageUsername extends StatelessWidget {
  const ImageUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: const Color(0xFFF7F7F9),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image.asset(
                  'lib/images/image1.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            FutureBuilder(
              future: APIService.getUserProfile(),
              builder: (
                BuildContext context,
                AsyncSnapshot<String> model,
              ) {
                if (model.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (model.hasError) {
                  return const Text('Error loading user profile');
                } else {
                  Map<String, dynamic> userData = json.decode(model.data!);
                  String userUsername = userData['username'];
                  return Text(userUsername);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
