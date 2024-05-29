import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class FriendsRequestPage extends StatefulWidget {
  const FriendsRequestPage({super.key});

  @override
  State<FriendsRequestPage> createState() => _FriendsRequestPageState();
}

class _FriendsRequestPageState extends State<FriendsRequestPage> {
  io.Socket? socket;
  List<Map<String, String>> friendRequests = [];
  String? userId;

  @override
  void initState() {
    super.initState();
    loadUserIdAndFetchData();
  }

  void loadUserIdAndFetchData() async {
    LoginResponseModel? loginResponse = await SharedService.loginDetails();
    if (loginResponse != null) {
      userId = loginResponse.id;
      fetchFriendRequests();
      connectToSocket();
    } else {
      // Handle the case where user is not logged in
      // You might want to redirect to the login page
    }
  }

  void fetchFriendRequests() async {
    if (userId != null) {
      var response = await APIService.getWaitingList(userId!);
      if (response != null && response.waitingList != null) {
        setState(() {
          friendRequests = response.waitingList!
              .map((request) => {
                    'userId': request.sId ?? 'Unknown',
                    'username': request.username ?? 'Unknown'
                  })
              .toList();
        });
      }
    }
  }

  void connectToSocket() {
    socket = io.io('http://10.0.2.2:8080', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.connect();

    socket?.on('connect', (_) {
      if (userId != null) {
        socket?.emit('join', userId);
      }
      debugPrint('connected to websocket');
    });

    socket?.on('receive_friend_request', (data) {
      setState(() {
        friendRequests.add({
          'userId': data['senderId'],
          'username': data['senderUsername'] ?? 'Unknown'
        });
      });
    });

    socket?.on('friend_request_accepted', (data) {
      // Handle logic when friend request is accepted
    });

    socket?.on('disconnect', (_) {
      debugPrint('disconnected from websocket');
    });
  }

  void sendFriendRequest(String receiverId) {
    if (userId != null) {
      socket?.emit('send_friend_request', {
        'senderId': userId,
        'receiverId': receiverId,
      });
    }
  }

  void acceptFriendRequest(String senderId) {
    if (userId != null) {
      socket?.emit('accept_friend_request', {
        'senderId': senderId,
        'receiverId': userId,
      });

      setState(() {
        friendRequests.removeWhere((request) => request['userId'] == senderId);
      });
    }
  }

  void rejectFriendRequest(String senderId) {
    if (userId != null) {
      socket?.emit('reject_friend_request', {
        'senderId': senderId,
        'receiverId': userId,
      });

      setState(() {
        friendRequests.removeWhere((request) => request['userId'] == senderId);
      });
    }
  }

  @override
  void dispose() {
    socket?.disconnect();
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
            const SizedBox(height: 10),
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
          Expanded(
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              acceptFriendRequest(senderId);
                            },
                            icon: const Icon(Icons.done),
                          ),
                          IconButton(
                            onPressed: () {
                              rejectFriendRequest(senderId);
                            },
                            icon: const Icon(Icons.do_not_disturb),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
