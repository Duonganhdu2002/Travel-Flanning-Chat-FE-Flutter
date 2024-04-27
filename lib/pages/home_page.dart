import 'package:flutter/material.dart';
import 'package:flutter_app/components/image_username.dart';
import 'package:flutter_app/components/notification_icon.dart';
import 'package:flutter_app/ultils/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBar(
        leftWidget: ImageUsername(),
        centerWidget: Text("Tuy y"),
        rightWidget: NotificationIcon(notificationExistence: true),
      ),
      body: userProfile(),
      backgroundColor: Colors.white,
    );
  }

  Widget userProfile() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            "Explore the ",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            "Beautiful world!",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
