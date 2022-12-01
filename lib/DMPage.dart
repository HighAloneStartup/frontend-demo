import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'dart:convert';

import './models/main_user.dart';

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
      appBar: AppBar(
        backgroundColor: const Color(0xff3D5D54), // const Color(0xFFE4F0ED), //
        title: const Text("Chat"),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return ChatElement(
                      isMe: docs[index]['uid'] == widget.user.uid,
                      userName: docs[index]['userName'],
                      text: docs[index]['text'],
                    );
                  },
                );
              },
            ),
          ),
          NewMessage(user: widget.user),
        ],
      ),
    );
  }
}

class ChatElement extends StatelessWidget {
  const ChatElement({super.key, this.isMe, this.userName, this.text});
  final bool? isMe;
  final String? userName;
  final String? text;

  @override
  Widget build(BuildContext context) {
    if (isMe!) {
      return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: ChatBubble(
          clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
          alignment: Alignment.topRight,
          margin: const EdgeInsets.only(top: 20),
          backGroundColor: const Color(0xFFE4F0ED), // const Color(0xff3D5D54),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  userName!,
                  style: const TextStyle(
                    color: Color(0xff3D5D54), // Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  text!,
                  style: const TextStyle(
                    color: Color(0xff3D5D54), // Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: ChatBubble(
          clipper: ChatBubbleClipper3(type: BubbleType.receiverBubble),
          backGroundColor:
              const Color(0xffE7E7ED), // const Color(0xff3D5D54), //
          margin: const EdgeInsets.only(top: 20),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName!,
                  style: const TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  text!,
                  style: const TextStyle(
                    color: Color(0xff3D5D54),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                color: const Color(0xff3D5D54),
                onPressed: newMessage.trim().isEmpty
                    ? null
                    : () {
                        FirebaseFirestore.instance.collection("chat").add({
                          'text': newMessage,
                          'userName': widget.user.name,
                          'timestamp': Timestamp.now(),
                          'uid': widget.user.uid,
                        });
                        newMessageController.clear();
                      },
                icon: const Icon(Icons.send)),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
