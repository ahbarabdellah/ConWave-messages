import 'package:chat/Components/text_field.dart';
import 'package:chat/servises/chat/chat_servises.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMsg(widget.recieveUserId, _messageController.text);
      // clear the text fild after sending the messge
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recieveUserEmail,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Expanded(
            child: _buildMessagelist(),
          ),
          // User Input with the send btn ??
          _buildMessageInput(),
        ]),
      ),
    );
  }

  Widget _buildMessagelist() {
    return StreamBuilder(
      stream: _chatService.getMsg(
          _firebaseAuth.currentUser!.uid, widget.recieveUserId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SnackBar(content: Text("Error : ${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading ...");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var aliment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.bottomLeft;

    var color = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Colors.lightBlueAccent
        : Colors.greenAccent;

    var cross = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      alignment: aliment,
      child: Column(
        crossAxisAlignment: cross,
        children: [
          Text(
            data["senderEmail"],
            style: const TextStyle(
              fontSize: 9,
              fontStyle: FontStyle.italic,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(9)),
            child: Text(
              data["message"],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(children: [
      Expanded(
        child: CTextFeild(
          controller: _messageController,
          obscureText: false,
          hintText: 'Enter Message',
        ),
      ),
      IconButton(
        onPressed: sendMessage,
        icon: const Icon(Icons.arrow_upward_outlined),
      )
    ]);
  }
}
