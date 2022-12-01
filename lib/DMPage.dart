import 'package:flutter/material.dart';
import './models/main_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DMPage extends StatefulWidget {
  final MainUser user;
  const DMPage({super.key, required this.user});

  @override
  State<DMPage> createState() => _DMPageState();
}

class _DMPageState extends State<DMPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NewMessage(
          user: widget.user,
        ),
      ),
    );
  }
}

class NewMessage extends StatefulWidget {
  final MainUser user;

  const NewMessage({super.key, required this.user});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String newMessage = '';

  final newMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: newMessageController,
              decoration: const InputDecoration(hintText: "New Message"),
              onChanged: (value) {
                setState(() {
                  newMessage = value;
                });
              },
            ),
          ),
        ),
        IconButton(
            color: Colors.blue,
            onPressed: newMessage.trim().isEmpty
                ? null
                : () {
                    final currentUser = widget.user;
                    FirebaseFirestore.instance.collection("chat").add({
                      'text': newMessage,
                      'userName': currentUser.name,
                      'timestamp': Timestamp.now(),
                      'uid': currentUser.uid,
                    });
                  },
            icon: const Icon(Icons.send)),
      ],
    );
  }
}
