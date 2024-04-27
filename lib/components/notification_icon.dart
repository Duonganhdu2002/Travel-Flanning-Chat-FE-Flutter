import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final bool notificationExistence;

  const NotificationIcon({super.key, required this.notificationExistence});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.notifications_none_outlined,
                color: Colors.black54,
                size: 35,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: notificationExistence
                    ? const EdgeInsets.all(4.0)
                    : const EdgeInsets.all(0.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: const Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
