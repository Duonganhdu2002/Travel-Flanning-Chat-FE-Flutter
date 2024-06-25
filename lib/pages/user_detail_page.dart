import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/friend_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:flutter_app/services/websocket_service.dart';
import 'package:flutter_app/pages/chat_page.dart'; // Import the ChatPage class

class UserDetailPage extends StatefulWidget {
  final String userId;

  const UserDetailPage({required this.userId, super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  Future<ResponseUserDetail?>? futureUserDetail;
  bool? areFriends;
  bool isRequestPending = false;
  late WebSocketService webSocketService;
  String? currentUserId;
  String? currentUsername;

  @override
  void initState() {
    super.initState();
    futureUserDetail = AuthService.getUserDetail(context, widget.userId);

    // Load current user details from cache
    _loadCurrentUser();
  }

  void _loadCurrentUser() async {
    final details = await SharedService.loginDetails();
    setState(() {
      currentUserId = details?.id;
      currentUsername = details?.username;
    });

    // Check friend status after loading user details
    if (currentUserId != null) {
      _checkFriendStatus(currentUserId!, widget.userId);
    }

    // Initialize WebSocketService after loading user details
    webSocketService = WebSocketService();
    webSocketService.connect(
      currentUserId!,
      (requests) => {}, // Handle initial friend requests if needed
      (data) {
        // Handle friend request received
        debugPrint('Friend request received: $data');
      },
      (data) {
        // Handle friend request accepted
        debugPrint('Friend request accepted: $data');
      },
      (data) {
        // Handle friend request rejected
        debugPrint('Friend request rejected: $data');
      },
    );
  }

  void _checkFriendStatus(String currentUserId, String otherUserId) async {
    final response =
        await FriendService.checkFriendStatus(currentUserId, otherUserId);
    if (response != null && response['status'] == 'friends') {
      setState(() {
        areFriends = true;
      });
    } else if (response != null && response['status'] == 'pending') {
      setState(() {
        areFriends = false;
        isRequestPending = true;
      });
    } else {
      setState(() {
        areFriends = false;
      });
    }
  }

  @override
  void dispose() {
    webSocketService.disconnect();
    super.dispose();
  }

  void _sendFriendRequest(String receiverId) {
    if (currentUserId == null || currentUsername == null) return;
    setState(() {
      isRequestPending = true;
    });

    try {
      debugPrint('Sending friend request from $currentUserId to $receiverId');
      webSocketService.sendFriendRequest(
          currentUserId!, receiverId, currentUsername!);
    } catch (e) {
      debugPrint('Error sending friend request: $e');
      setState(() {
        isRequestPending = false;
      });
    }
  }

  void _unfriend(String friendId) async {
    if (currentUserId == null) return;

    try {
      debugPrint('Unfriending $friendId');
      await FriendService.unfriendUser(currentUserId!, friendId);
      webSocketService.unfriend(currentUserId!, friendId);
      setState(() {
        areFriends = false;
      });
    } catch (e) {
      debugPrint('Error unfriending: $e');
    }
  }

  void _navigateToChatPage(
      BuildContext context, String friendId, String friendUsername) {
    if (currentUserId == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          userId: currentUserId!,
          friendId: friendId,
          friendUsername: friendUsername,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBar(
        leftWidget: BackIcon(),
      ),
      body: FutureBuilder<ResponseUserDetail?>(
        future: futureUserDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("User not found"));
          } else {
            final userDetail = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'lib/images/image1.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      userDetail.username ?? "No username",
                      style: const TextStyle(
                        color: Color(0xFF1B1E28),
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: TextButton.icon(
                              onPressed: () {
                                _navigateToChatPage(
                                    context,
                                    userDetail.id.toString(),
                                    userDetail.username ?? "No username");
                              },
                              icon: ImageFiltered(
                                imageFilter: const ColorFilter.mode(
                                    Color(0xFF7D848D), BlendMode.srcATop),
                                child: SvgPicture.asset(
                                  "lib/images/Caht.svg",
                                  width: 20,
                                  height: 30,
                                ),
                              ),
                              label: const Text(
                                'Message',
                                style: TextStyle(
                                  color: Color(0xFF7D848D),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        if (areFriends == false && !isRequestPending)
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD521),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: IconButton(
                              icon: ImageFiltered(
                                imageFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcATop),
                                child: SvgPicture.asset(
                                  "lib/images/add-friend.svg",
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              onPressed: () {
                                _sendFriendRequest(userDetail.id.toString());
                              },
                            ),
                          ),
                        if (isRequestPending)
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD521),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: IconButton(
                              icon: ImageFiltered(
                                imageFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcATop),
                                child: SvgPicture.asset(
                                  "lib/images/pending-request.svg",
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              onPressed:
                                  null, // Disable button when request is pending
                            ),
                          ),
                        if (areFriends == true)
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD521),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: IconButton(
                              icon: ImageFiltered(
                                imageFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcATop),
                                child: SvgPicture.asset(
                                  "lib/images/remove-friend.svg",
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              onPressed: () {
                                _unfriend(userDetail.id.toString());
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
