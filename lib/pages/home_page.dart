import 'package:flutter/material.dart';
import 'package:flutter_app/components/home_component.dart';
import 'package:flutter_app/components/image_username.dart';
import 'package:flutter_app/components/notification_icon.dart';
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
    const Text("Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBar(
        leftWidget: ImageUsername(),
        rightWidget: NotificationIcon(notificationExistence: true),
      ),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: CustomBottomBar(
        onTabChange: (index) => navigateBottomBar(index),
        selectedIndex: selected,
      ),
      body: page[selected],
    );
  }
}
