import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class FriendsRequestPage extends StatefulWidget {
  const FriendsRequestPage({super.key});

  @override
  State<FriendsRequestPage> createState() => _FriendsRequestPageState();
}

class _FriendsRequestPageState extends State<FriendsRequestPage> {
  io.Socket? socket;
  List<Map<String, String>> friendRequests = [];

  @override
  void initState() {
    super.initState();

    // Initialize socket connection
    socket = io.io('http://localhost:8080', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket?.on('connect', (_) {
      print('connected to websocket');
    });

    socket?.on('receive_friend_request', (data) {
      print('Friend request received: $data');
      setState(() {
        friendRequests.add({
          'userId': data['senderId'],
          'username': data['username'],
        });
      });
    });

    socket?.on('disconnect', (_) {
      print('disconnected from websocket');
    });
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
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Handle accept friend request
                          },
                          icon: const Icon(Icons.done),
                        ),
                        IconButton(
                          onPressed: () {
                            // Handle reject friend request
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
