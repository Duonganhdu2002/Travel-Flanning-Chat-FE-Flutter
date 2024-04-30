import 'package:flutter/material.dart';
import 'package:flutter_app/components/home_component.dart';
import 'package:flutter_app/components/image_username.dart';
import 'package:flutter_app/components/notification_icon.dart';
import 'package:flutter_app/components/profile.dart';
import 'package:flutter_app/ultils/app_bar.dart';
import 'package:flutter_app/ultils/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;
  void navigateBottomBar(int index) {
    setState(() {
      selected = index;
    });
  }

  final List<Widget> page = [
    const HomeComponent(),
    const Text("Calendar"),
    const Text("Messages"),
    const Text("Seacrh"),
    const ProfileUser(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomBar(selected),
      backgroundColor: const Color(0xFFFFFFFF),
      bottomNavigationBar: CustomBottomBar(
        onTabChange: (index) => navigateBottomBar(index),
        selectedIndex: selected,
      ),
      body: page[selected],
    );
  }

  PreferredSizeWidget buildCustomBar(int selected) {
    switch (selected) {
      case 0:
        return const CustomBar(
          leftWidget: ImageUsername(),
          rightWidget: NotificationIcon(notificationExistence: true),
        );
      case 1:
        return const CustomBar(
          leftWidget: Text(
            "          ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerWidget: Text(
            "Schedule",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          rightWidget: NotificationIcon(notificationExistence: false),
        );
      case 2:
        return const CustomBar(
          leftWidget: ImageUsername(),
          rightWidget: NotificationIcon(notificationExistence: true),
        );
      case 3:
        return const CustomBar(
          leftWidget: ImageUsername(),
          rightWidget: NotificationIcon(notificationExistence: true),
        );
      case 4:
        return const CustomBar(
          centerWidget: Text(
            "Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      default:
        return const CustomBar(
          leftWidget: ImageUsername(),
          rightWidget: NotificationIcon(notificationExistence: false),
        );
    }
  }
}
