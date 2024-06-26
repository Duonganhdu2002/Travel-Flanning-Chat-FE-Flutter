import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/components/create_group.dart';
import 'package:flutter_app/components/search_input.dart';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/pages/chat_page.dart';
import 'package:flutter_app/services/friend_service.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateMessage extends StatefulWidget {
  const CreateMessage({super.key});

  @override
  State<CreateMessage> createState() => _CreateMessageState();
}

class _CreateMessageState extends State<CreateMessage> {
  List<Map<String, String>> friends = [];
  List<Map<String, String>> filteredFriends = [];

  @override
  void initState() {
    super.initState();
    _fetchFriends();
  }

  void _fetchFriends() async {
    try {
      final details = await SharedService.loginDetails();
      String userId = details?.id ?? '';
      if (userId.isNotEmpty) {
        List<Map<String, String>> fetchedFriends =
            await FriendService.getFriendList(userId);
        setState(() {
          friends = fetchedFriends;
          filteredFriends = fetchedFriends;
        });
      }
    } catch (e) {
      debugPrint('Error fetching friends: $e');
    }
  }

  void _handleSearch(String query) {
    setState(() {
      filteredFriends = friends
          .where((friend) =>
              friend['username']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToChat(
      BuildContext context, String friendId, String username) async {
    final details = await SharedService.loginDetails();
    String userId = details?.id ?? '';
    if (userId.isNotEmpty) {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            userId: userId,
            friendId: friendId,
            friendUsername: username,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomBar(
        leftWidget: BackIcon(),
        centerWidget1: Text(
          "New Messages",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        rightWidget: Text("           "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchInput(
              hintText: 'Search friends',
              onSearch: _handleSearch,
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateGroup()),
                );
              },
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Stack(
                      children: [
                        IconButton(
                          icon: ImageFiltered(
                            imageFilter: const ColorFilter.mode(
                                Colors.black12, BlendMode.srcATop),
                            child: SvgPicture.asset(
                              "lib/images/UserGroup.svg",
                              width: 24,
                              height: 24,
                            ),
                          ),
                          onPressed: () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            } else {
                              // Trang hiện tại là trang gốc, không thực hiện pop
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Create a group chat",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 200),
                  SvgPicture.asset(
                    "lib/images/RightArrow.svg",
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Suggested",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: filteredFriends.length,
                itemBuilder: (context, index) {
                  return itemMessage(
                    context,
                    '${Config.apiURL}public/images/avatars/${filteredFriends[index]['avatar']}',
                    filteredFriends[index]['username']!,
                    filteredFriends[index]['userId']!,
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
    String userId,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: InkWell(
        onTap: () {
          _navigateToChat(context, userId, nameUser);
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            const ImageFiltered(
                              imageFilter: ColorFilter.mode(
                                Color(0xFF7D848D),
                                BlendMode.srcATop,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemGroupMessage(
    BuildContext context,
    String userImage,
    String friendImage,
    String groupName,
    String membersName,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Stack(children: [
                      Positioned(
                        child: SizedBox(
                          width: 55,
                          child: Image.network(
                            userImage,
                            width: 55,
                            height: 55,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: SizedBox(
                          width: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white70),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.network(
                              friendImage,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ]),
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
                              groupName,
                              style: const TextStyle(
                                  color: Color(0xFF1B1E28),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            const ImageFiltered(
                              imageFilter: ColorFilter.mode(
                                Color(0xFF7D848D),
                                BlendMode.srcATop,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          membersName,
                          style: const TextStyle(color: Color(0xFF7D848D)),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    "lib/images/RightArrow.svg",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
