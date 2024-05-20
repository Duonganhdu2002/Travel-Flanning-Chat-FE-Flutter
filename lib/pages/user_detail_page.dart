import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserDetailPage extends StatefulWidget {
  final String userId;

  const UserDetailPage({required this.userId, super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  Future<ResponseUserDetail?>? futureUserDetail;

  @override
  void initState() {
    super.initState();
    futureUserDetail = APIService.getUserDetail(context, widget.userId);
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
                                // Handle button press
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
                            onPressed: () {},
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
