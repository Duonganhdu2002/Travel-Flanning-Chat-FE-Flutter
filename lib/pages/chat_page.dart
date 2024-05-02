import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/components/back_icon.dart';

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
        centerWidget1: Text("Aloha"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        ),
    );
  }
}