import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Friend List'),
        backgroundColor: Colors.white,
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            child: ListView.builder(
              itemCount: friendList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: SizedBox(
                          child: friendList[index]['avatar'] != null
                              ? Image.asset(
                                  "lib/images/${friendList[index]['avatar']}")
                              : null,
                        ),
                        title: Text(
                          friendList[index]['username']!,
                          style: const TextStyle(
                              color: Color(0xFF1B1E28),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
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
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
