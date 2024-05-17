import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/components/call_icon.dart';
import 'package:flutter_app/components/text_input.dart';
import 'package:flutter_app/components/sender_message.dart';
import 'package:flutter_app/components/receiver_message.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> messages = [
    {"type": "sender", "message": "Hello!"},
    {"type": "receiver", "message": "Hi there!"},
    {"type": "sender", "message": "How are you?"},
    {"type": "receiver", "message": "I'm good, thank you!"},
  ];

  late io.Socket socket;

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    socket = io.io('http://10.0.2.2:8080', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) {
      print('connected');
    });

    socket.on('message', (data) {
      setState(() {
        messages.add(data);
      });
    });
  }

  void sendMessage(String message) {
    final msg = {'type': 'sender', 'message': message};
    socket.emit('message', msg);
    setState(() {
      messages.add(msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomBar(
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  if (message["type"] == "sender") {
                    return SenderMessage(message: message["message"]!);
                  } else {
                    return ReceiverMessage(message: message["message"]!);
                  }
                },
              ),
            ),
          ),
          SafeArea(
            child: TextInput(onSendMessage: sendMessage),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ChatPage(),
  ));
}
