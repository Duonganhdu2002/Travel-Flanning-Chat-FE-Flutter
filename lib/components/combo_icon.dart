import 'package:flutter/material.dart';
import 'package:flutter_app/pages/add_friend_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ComboIcon extends StatelessWidget {
  const ComboIcon({super.key});

  void _onSelected(BuildContext context, String choice) {
    switch (choice) {
      case "1":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddFriendPage()),
        );
        break;
      case '2':
        // Handle xem danh sách nhóm action here
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(40),
      ),
      child: Stack(
        children: [
          PopupMenuButton<String>(
            color: Colors.white,
            shadowColor: Colors.grey[50],
            icon: ImageFiltered(
              imageFilter:
                  const ColorFilter.mode(Colors.black12, BlendMode.srcATop),
              child: SvgPicture.asset(
                "lib/images/combo.svg",
                width: 16,
                height: 16,
              ),
            ),
            onSelected: (String choice) {
              _onSelected(context, choice);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: '1',
                  child: Row(
                    children: [
                      Icon(Icons.person_add),
                      SizedBox(width: 8),
                      Text('Add friend'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: '2',
                  child: Row(
                    children: [
                      Icon(Icons.group),
                      SizedBox(width: 8),
                      Text('List group'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
