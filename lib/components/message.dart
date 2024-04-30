import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Messages"),
              ImageFiltered(
                imageFilter: const ColorFilter.mode(
                    Color(0xFF7D848D), BlendMode.srcATop),
                child: SvgPicture.asset(
                  "lib/images/next.svg",
                  height: 16,
                ),
              ),
            ],
          ),
          Container(),
          const Expanded(
              child: Column(
            children: [Row()],
          ))
        ],
      ),
    );
  }
}
