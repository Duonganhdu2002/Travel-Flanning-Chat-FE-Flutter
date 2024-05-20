import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/pages/user_detail_page.dart';
import 'package:flutter_app/services/api_service.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  Future<List<User>>? futureUsers;
  List<User>? allUsers;
  List<User>? filteredUsers;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureUsers = APIService.getCachedUsers();
    futureUsers?.then((users) {
      setState(() {
        allUsers = users;
        filteredUsers = []; // Initialize with an empty list
      });
    });
    searchController.addListener(() {
      filterUsers();
    });
  }

  void filterUsers() {
    List<User>? users = allUsers;
    String query = searchController.text.toLowerCase();
    if (query.isNotEmpty && users != null) {
      setState(() {
        filteredUsers = users.where((user) {
          return user.username!.toLowerCase().contains(query);
        }).toList();
      });
    } else {
      setState(() {
        filteredUsers = [];
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    APIService.removeCache(context, "all_users");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBar(
        leftWidget: BackButton(),
        centerWidget1: Text(
          "Add friend",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        rightWidget: Text("               "),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              hintText: 'Search friends name',
                              hintStyle: TextStyle(
                                color: Color(0xFF7D848D),
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: FutureBuilder<List<User>>(
                future: futureUsers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else {
                    return ListView.builder(
                      itemCount: filteredUsers!.length,
                      itemBuilder: (context, index) {
                        User user = filteredUsers![index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserDetailPage(
                                      userId: user.id.toString()),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.asset(
                                    "lib/images/Detail_img4.jpg",
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.username ?? "No username",
                                        style: const TextStyle(
                                          color: Color(0xFF1B1E28),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
