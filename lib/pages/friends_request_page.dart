import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';

class FriendsRequestPage extends StatefulWidget {
  const FriendsRequestPage({super.key});

  @override
  State<FriendsRequestPage> createState() => _FriendsRequestPageState();
}

class _FriendsRequestPageState extends State<FriendsRequestPage> {
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
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Friends request",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView(
                children: [
                  itemMessage(
                    context,
                    "lib/images/User_img.png",
                    "Tom Liebt Dich",
                  ),
                  itemMessage(
                    context,
                    "lib/images/User_img.png",
                    "Tom Liebt Dich",
                  ),
                  itemMessage(
                    context,
                    "lib/images/User_img.png",
                    "Tom Liebt Dich",
                  ),
                  itemMessage(
                    context,
                    "lib/images/User_img.png",
                    "Tom Liebt Dich",
                  ),
                ],
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
                const SizedBox(
                  width: 20,
                ),
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
                          const SizedBox(
                            width: 50,
                          ),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.done)),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.do_not_disturb))
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
