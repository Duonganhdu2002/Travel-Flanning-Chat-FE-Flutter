// ignore_for_file: library_prefixes, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_app/components/create_message.dart';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/pages/chat_page.dart';
import 'package:flutter_app/components/search_input.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageComponent extends StatefulWidget {
  const MessageComponent({super.key});

  @override
  State<MessageComponent> createState() => _MessageComponentState();
}

class _MessageComponentState extends State<MessageComponent> {
  List<Map<String, dynamic>> conversations = [];
  List<Map<String, dynamic>> filteredConversations = [];
  LoginResponseModel? loginDetails;
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    _initializeSocket();
    _loadLoginDetails();
  }

  void _loadLoginDetails() async {
    final details = await SharedService.loginDetails();
    if (details != null) {
      setState(() {
        loginDetails = details;
      });
      _fetchInitialConversations();
    } else {
      print('Login details are null');
    }
  }

  void _initializeSocket() {
    socket = IO.io(
        'http://10.0.2.2:8080',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.connect();

    socket.on('connect', (_) {
      print('Connected to socket server');
      // Fetch initial conversations if needed
      if (loginDetails != null) {
        _fetchInitialConversations();
      }
    });

    socket.on('disconnect', (_) {
      print('Disconnected from socket server');
    });

    socket.on('initial_conversations', (data) {
      setState(() {
        conversations = List<Map<String, dynamic>>.from(data);
        filteredConversations = conversations;
      });
    });
  }

  void _fetchInitialConversations() {
    if (loginDetails != null) {
      socket.emit('fetch_conversations', {'userId': loginDetails!.id});
    }
  }

  void _searchConversations(String query) {
    if (loginDetails == null) {
      return;
    }

    setState(() {
      filteredConversations = conversations
          .where((conversation) => conversation['participants'].any(
              (participant) =>
                  participant['username']
                      .toLowerCase()
                      .contains(query.toLowerCase()) &&
                  participant['_id'] != loginDetails!.id))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loginDetails == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Messages",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateMessage()),
                    );
                  },
                  child: ImageFiltered(
                    imageFilter: const ColorFilter.mode(
                        Color(0xFF1B1E28), BlendMode.srcATop),
                    child: SvgPicture.asset(
                      "lib/images/writer.svg",
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SearchInput(onSearch: _searchConversations),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredConversations.length,
                itemBuilder: (context, index) {
                  final conversation = filteredConversations[index];
                  final latestMessage = conversation['messages'].isNotEmpty
                      ? conversation['messages'][0]['message']
                      : 'No messages yet';
                  final friend = conversation['participants'].firstWhere(
                    (participant) => participant['_id'] != loginDetails!.id,
                    orElse: () => null,
                  );

                  if (friend == null) {
                    return Container(); // or handle the empty case as needed
                  }

                  return itemMessage(
                    context,
                    friend['avatar'] != null
                        ? "${Config.apiURL}public/images/avatars/${friend['avatar']}"
                        : "${Config.apiURL}public/images/avatars/User_img.png",
                    friend['username'],
                    latestMessage,
                    1, // Replace with actual status if available
                    '07:76', // Replace with actual time if available
                    friend['_id'],
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
    String nameUser,
    String showMessage,
    int statusMessage,
    String timeSend,
    String friendId,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: InkWell(
        onTap: () {
          if (loginDetails != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  userId: loginDetails!.id ?? '', // Use the actual user ID
                  friendId: friendId,
                  friendUsername: nameUser,
                ),
              ),
            );
          }
        },
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Image.network(
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
                              nameUser,
                              style: const TextStyle(
                                  color: Color(0xFF1B1E28),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            ImageFiltered(
                              imageFilter: const ColorFilter.mode(
                                Color(0xFF7D848D),
                                BlendMode.srcATop,
                              ),
                              child: SvgPicture.asset(
                                statusMessage == 1
                                    ? "lib/images/sent.svg"
                                    : statusMessage == 2
                                        ? "lib/images/received.svg"
                                        : "lib/images/seen.svg",
                                width: 14,
                                height: 14,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          showMessage,
                          style: const TextStyle(color: Color(0xFF7D848D)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 60,
              child: Text(
                timeSend,
                style: const TextStyle(
                  color: Color(0xFF7D848D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
