import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/components/call_icon.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomBar(
        leftWidget: BackIcon(),
        centerWidget1: Text("Aloha",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerWidget2: Text("Active now",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green)),
        rightWidget: CallIcon(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
