import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/components/search_input.dart';
import 'package:flutter_app/models/list_friend_suggest_model.dart';
import 'package:flutter_app/pages/details_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<String> selectedFriends = [];

  void toggleSelection(String friendId) {
    setState(() {
      if (selectedFriends.contains(friendId)) {
        selectedFriends.remove(friendId);
      } else {
        selectedFriends.add(friendId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomBar(
        leftWidget: BackIcon(),
        centerWidget1: Text(
          "New Group",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        rightWidget: Text("              "),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetailsPage()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFD521), // Background color
              borderRadius: BorderRadius.circular(12), // BorderRadius
            ),
            height: 55,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Create Group',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchInput(),
            const SizedBox(height: 15),
            if (selectedFriends.isNotEmpty)
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedFriends.length,
                  itemBuilder: (context, index) {
                    final selectedFriendId = selectedFriends[index];
                    final friend = listFriendSuggestModel.firstWhere(
                        (friend) => friend.userId == selectedFriendId);

                    return Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: SizedBox(
                        width: 70,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.asset(
                                friend.imagePath,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: SvgPicture.asset(
                                    "lib/images/delete.svg",
                                    width: 16,
                                    height: 16,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedFriends.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
                itemCount: listFriendSuggestModel.length,
                itemBuilder: (context, index) {
                  final friend = listFriendSuggestModel[index];
                  final isSelected = selectedFriends.contains(friend.userId);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: InkWell(
                      onTap: () => toggleSelection(friend.userId),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.asset(
                              friend.imagePath,
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
                                Text(
                                  friend.userName,
                                  style: const TextStyle(
                                    color: Color(0xFF1B1E28),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : Colors.grey,
                                width: 2,
                              ),
                              color: isSelected
                                  ? const Color(0xFFFFD521)
                                  : Colors.transparent,
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
