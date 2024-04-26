import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_app/services/shared_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter+NodeJS+JWT'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              SharedService.logOut(context);
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: userProfile(),
    );
  }

  Widget userProfile() {
    return FutureBuilder(
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
          return const Center(
            child: Text('Error loading user profile'),
          );
        } else {
          // Decode JSON data
          Map<String, dynamic> userData = json.decode(model.data!);
          // Extract user ID
          String userId = userData['id'];
          String userUsername = userData['username'];
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(userId), Text(userUsername)],
          ));
        }
      },
    );
  }
}
