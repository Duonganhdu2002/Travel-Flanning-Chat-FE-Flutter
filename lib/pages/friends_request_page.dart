import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/services/friend_service.dart';
import 'package:flutter_app/services/websocket_service.dart';
import 'package:flutter_app/services/shared_service.dart';

class FriendsRequestPage extends StatefulWidget {
  const FriendsRequestPage({super.key});

  @override
  State<FriendsRequestPage> createState() => _FriendsRequestPageState();
}

class _FriendsRequestPageState extends State<FriendsRequestPage> {
  WebSocketService? webSocketService;
  List<Map<String, String>> friendRequests = [];
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

    // Initialize WebSocket connection
    _initializeWebSocket(details?.id);

    // Fetch friend requests via API
    _fetchFriendRequests(details?.id);
  }

  void _initializeWebSocket(String? userId) {
    if (userId == null) return;

    webSocketService = WebSocketService();
    webSocketService?.connect(
      userId,
      _handleInitialFriendRequests,
      _handleFriendRequestReceived,
      _handleFriendRequestAccepted,
      _handleFriendRequestRejected,
    );
  }

  void _fetchFriendRequests(String? userId) async {
    if (userId == null) return;

    try {
      final requests = await FriendService.getFriendRequests(userId);
      setState(() {
        friendRequests = requests.map((request) {
          return {
            'userId': request['userId']!,
            'username': request['username']!,
          };
        }).toList();
      });
    } catch (e) {
      debugPrint('Error fetching friend requests: $e');
    }
  }

  void _handleInitialFriendRequests(List<Map<String, String>> requests) {
    setState(() {
      friendRequests = requests;
    });
  }

  void _handleFriendRequestReceived(Map<String, String> data) {
    setState(() {
      friendRequests.add({
        'userId': data['userId']!,
        'username': data['username']!,
      });
    });
  }

  void _handleFriendRequestAccepted(Map<String, String> data) {
    setState(() {
      friendRequests
          .removeWhere((request) => request['userId'] == data['friendId']);
    });
  }

  void _handleFriendRequestRejected(Map<String, String> data) {
    setState(() {
      friendRequests
          .removeWhere((request) => request['userId'] == data['friendId']);
    });
  }

  void _acceptFriendRequest(String friendId) {
    if (currentUserId == null) return;

    debugPrint('Accepting friend request from $friendId');
    webSocketService?.acceptFriendRequest(currentUserId!, friendId);
  }

  void _rejectFriendRequest(String friendId) {
    if (currentUserId == null) return;

    debugPrint('Rejecting friend request from $friendId');
    webSocketService?.rejectFriendRequest(currentUserId!, friendId);
  }

  @override
  void dispose() {
    webSocketService?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBar(
        leftWidget: BackButton(),
        centerWidget1: Text(
          "Friends Request",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        rightWidget: Text("               "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const Text(
              "Friends request",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: friendRequests.length,
                itemBuilder: (context, index) {
                  return itemMessage(
                    context,
                    "lib/images/User_img.png",
                    friendRequests[index]['userId']!,
                    friendRequests[index]['username']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemMessage(
    BuildContext context,
    String pathImage,
    String senderId,
    String username,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Image.asset(
              pathImage,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                          color: Color(0xFF1B1E28),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _acceptFriendRequest(senderId);
                          },
                          icon: const Icon(Icons.done),
                        ),
                        IconButton(
                          onPressed: () {
                            _rejectFriendRequest(senderId);
                          },
                          icon: const Icon(Icons.do_not_disturb),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
