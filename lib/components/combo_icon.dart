import 'package:flutter/material.dart';
import 'package:flutter_app/pages/add_friend_page.dart';
import 'package:flutter_app/pages/friends_request_page.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ComboIcon extends StatelessWidget {
  const ComboIcon({super.key});

  void _onSelected(BuildContext context, String choice) async {
    switch (choice) {
      case "1":
        await APIService.fetchAndCacheAllUsers();
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const AddFriendPage()),
        );
        break;
      case '2':
        // Handle xem danh sách nhóm action here
        break;
      case '3':
        // Handle xem danh sách nhóm action here
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const FriendsRequestPage()),
        );
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
                const PopupMenuItem<String>(
                  value: '3',
                  child: Row(
                    children: [
                      Icon(Icons.group_add),
                      SizedBox(width: 8),
                      Text('Friend Requests'),
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
