import 'package:flutter/material.dart';
import 'package:flutter_app/components/combo_icon.dart';
import 'package:flutter_app/components/home_component.dart';
import 'package:flutter_app/components/image_username.dart';
import 'package:flutter_app/components/logout_icon.dart';
import 'package:flutter_app/components/message.dart';
import 'package:flutter_app/components/notification_icon.dart';
import 'package:flutter_app/components/profile.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/components/nav_bar.dart';
import 'package:flutter_app/pages/aaaa.dart';

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
    const UserListScreen(),
    const Text("Messages"),
    const MessageComponent(),
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
          centerWidget1: Text(
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
          leftWidget: Text(
            "          ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerWidget1: Text(
            "Messages",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          rightWidget: ComboIcon(),
        );
      case 4:
        return const CustomBar(
          centerWidget1: Text(
            "Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          rightWidget: LogoutComponent(),
        );
      default:
        return const CustomBar(
          leftWidget: ImageUsername(),
          rightWidget: NotificationIcon(notificationExistence: false),
        );
    }
  }
}
