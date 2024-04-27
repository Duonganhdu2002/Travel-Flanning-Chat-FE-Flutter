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
        rightWidget: NotificationIcon(notificationExistence: true),
      ),
      body: userProfile(),
      backgroundColor: Colors.white,
    );
  }

  Widget userProfile() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Explore the ",
              style: TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              children: [
                const Text(
                  "Beautiful ",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      "world!",
                      style: TextStyle(
                        fontSize: 50,
                        color: Color(0xFFFF7029),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Image.asset(
                      'lib/images/text_under.png',
                      width: 120,
                      fit: BoxFit.contain,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Best Destination",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "View all",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.amber,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
