import 'package:flutter/material.dart';
import 'package:flutter_app/services/friend_service.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:flutter_app/pages/user_detail_page.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({super.key});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  List<Map<String, String>> friendList = [];
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() async {
    final details = await SharedService.loginDetails();
    setState(() {
      currentUserId = details?.id;
    });

    // Fetch friend list via API
    _fetchFriendList(details?.id);
  }

  void _fetchFriendList(String? userId) async {
    if (userId == null) return;

    try {
      final friends = await FriendService.getFriendList(userId);
      setState(() {
        friendList = friends;
      });
    } catch (e) {
      debugPrint('Error fetching friend list: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend List'),
      ),
      body: ListView.builder(
        itemCount: friendList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(friendList[index]['username']![0].toUpperCase()),
            ),
            title: Text(friendList[index]['username']!),
            onTap: () {
              // Navigate to UserDetailPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailPage(
                    userId: friendList[index]['userId']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
