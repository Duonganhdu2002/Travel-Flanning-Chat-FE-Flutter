import 'package:flutter/material.dart';
import 'package:flutter_app/components/create_message.dart';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/pages/chat_page.dart';
import 'package:flutter_app/components/search_input.dart';
import 'package:flutter_app/services/conversation_service.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageComponent extends StatefulWidget {
  const MessageComponent({super.key});

  @override
  State<MessageComponent> createState() => _MessageComponentState();
}

class _MessageComponentState extends State<MessageComponent> {
  List<Map<String, dynamic>> conversations = [];
  List<Map<String, dynamic>> filteredConversations = [];
  String userId = '';

  @override
  void initState() {
    super.initState();
    _fetchConversations();
  }

  Future<void> _fetchConversations() async {
    try {
      final details = await SharedService.loginDetails();
      userId = details?.id ?? '';
      List<Map<String, dynamic>> fetchedConversations =
          await ConversationService.getConversations(userId);
      setState(() {
        conversations = fetchedConversations;
        filteredConversations = fetchedConversations;
      });
    } catch (e) {
      debugPrint('Error fetching conversations: $e');
    }
  }

  void _searchConversations(String query) {
    setState(() {
      filteredConversations = conversations
          .where((conversation) => conversation['participants'].any(
              (participant) =>
                  participant['username']
                      .toLowerCase()
                      .contains(query.toLowerCase()) &&
                  participant['_id'] != userId))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    (participant) => participant['_id'] != userId,
                    orElse: () => null,
                  );

                  if (friend == null) {
                    return Container(); // or handle the empty case as needed
                  }

                  return itemMessage(
                    context,
                    friend['avatar'] != null
                        ? "${Config.apiURL}public/images/avatars${friend['avatar']}"
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                userId: userId, // Use the actual user ID
                friendId: friendId,
                friendUsername: nameUser,
              ),
            ),
          );
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
