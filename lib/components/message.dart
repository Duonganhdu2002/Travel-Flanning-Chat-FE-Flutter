import 'package:flutter/material.dart';
import 'package:flutter_app/pages/chat_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
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
                ImageFiltered(
                  imageFilter: const ColorFilter.mode(
                      Color(0xFF1B1E28), BlendMode.srcATop),
                  child: SvgPicture.asset(
                    "lib/images/writer.svg",
                    height: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F9),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  ImageFiltered(
                    imageFilter: const ColorFilter.mode(
                      Color(0xFF7D848D),
                      BlendMode.srcATop,
                    ),
                    child: SvgPicture.asset(
                      "lib/images/Search.svg",
                      width: 28,
                      height: 28,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for chats & messages',
                        hintStyle: TextStyle(
                            color: Color(0xFF7D848D),
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  itemMessage(context, "lib/images/User_img.png", "HAHAHAHA",
                      "aaaaaaaa", 1, "07:76"),
                ],
              ),
            )
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
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatPage()),
          );
        },
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
                textAlign: TextAlign.end,
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
