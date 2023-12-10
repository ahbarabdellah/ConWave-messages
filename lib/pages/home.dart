import 'package:chat/pages/chat_page.dart';
import 'package:chat/servises/auth/auth_servises.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    final authServise = Provider.of<AuthServises>(context, listen: false);
    authServise.signout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: const Text("Home Page"),
        actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout))],
      ),
    );
  }

  Widget _listOfUsers() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading ...");
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buikdUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buikdUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                recieveUserEmail: data['email'],
                recieveUserId: data['userID'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
