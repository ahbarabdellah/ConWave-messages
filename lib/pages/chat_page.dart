import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String recieveUserEmail;
  final String recieveUserId;
  const ChatPage({
    super.key,
    required this.recieveUserEmail,
    required this.recieveUserId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recieveUserEmail,
        ),
      ),
    );
  }
}
